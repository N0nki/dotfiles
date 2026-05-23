---
name: supply-chain-audit
description: ユーザーが Homebrew (brew upgrade / outdated)、Mac App Store (mas upgrade / outdated)、または Neovim プラグイン (lazy.nvim / lazy-lock.json) の更新を「実行する前」に安全性を確認したいときに使う。典型的には「アップデート前に怪しいやつがないか調べて」「サプライチェーン攻撃の観点でチェック」「依存関係の安全性確認」「乗っ取られてないか事前に見て」など、更新候補のパッケージごとに GitHub Security Advisory・関連 Issue・メンテナー変更・SNS/ニュース上の警告を横断調査し、HIGH/MEDIUM/LOW の判定付き Markdown レポートを生成する用途。「更新前」「アップデート前」「upgrade 前」「sync 前」というタイミングと、「怪しい」「乗っ取り」「サプライチェーン」「安全性」「依存関係チェック」という安全性懸念がセットで現れたら呼ぶ。npm/pip/cargo など他エコシステムや、CVE 解説、Brewfile への新規追加、コミットメッセージ生成では使わない。
---

# Supply Chain Audit

パッケージ・プラグインを更新する前に、公開情報を横断して「いま更新して大丈夫か」を判定するスキル。

ユーザーは更新を実行する前にこのスキルを呼ぶ。**勝手に `brew upgrade` / `mas upgrade` / `:Lazy sync` を実行しない**。出力は「人間が見てから更新するかを判断するためのレポート」であって、自動更新ツールではない。

## 対象

| マネージャー       | 更新候補の検出元                    | 主なリポジトリ調査先                                         |
| ------------------ | ----------------------------------- | ------------------------------------------------------------ |
| Homebrew (formula) | `brew outdated --formula --json=v2` | `brew info --json=v2 <name>` の `urls.head.url` / `homepage` |
| Homebrew (cask)    | `brew outdated --cask --json=v2`    | `brew info --cask --json=v2 <name>` の `homepage`            |
| mas                | `mas outdated`                      | App Store の公開情報 (バージョン履歴・ベンダー)              |
| Neovim プラグイン  | `lazy-lock.json` の git diff        | `lua/plugins.lua` から GitHub `owner/repo` を解決            |

## 全体ワークフロー

1. **更新候補をリストアップする**
2. **各候補を中程度の深さで調査する**
3. **Markdown レポートを出力する**

詳細手順は対象マネージャーごとに異なる。実行前に該当するリファレンスを読むこと。

- Homebrew → [references/homebrew.md](references/homebrew.md)
- mas → [references/mas.md](references/mas.md)
- Neovim プラグイン → [references/neovim.md](references/neovim.md)

ユーザーが特定のマネージャーだけを指定した場合 (例: 「brew だけ」) は、そのリファレンスだけ読めばよい。全部と言われた場合は3つ全部を扱う。

## Step 1: 更新候補のリストアップ

最初にどのパッケージが更新対象になるのかを把握する。手動で各コマンドを叩いてもよいが、ヘルパースクリプトを使うと一気に拾える:

```bash
bash ~/dotfiles/.claude/skills/supply-chain-audit/scripts/list_pending_updates.sh
```

出力:

- `brew_formula`: formula 名 / 現在 / 最新 / pin 状態
- `brew_cask`: cask 名 / 現在 / 最新
- `mas`: アプリ ID / 名前 / 現在 → 最新
- `nvim`: プラグイン名 / 旧 commit / 新 commit / GitHub URL

候補が1つもなければ更新の必要なしと報告して終了。

候補が多すぎる場合 (>30件など) は、ユーザーに「全部見るか、メンテナンス指標で絞るか」を確認する。全部見ようとすると WebFetch の呼び出しが膨大になる。

## Step 2: 中程度の調査

各候補について以下の **公開情報** を中心に確認する。重視するのは「外から見える警告サイン」で、コードを読んで難読化を疑うような深掘りはしない (それは「徹底的」モードの仕事)。

### 必須チェック

各 GitHub リポジトリについて、`gh` CLI で次を取得する:

```bash
# Security Advisory (必須)
gh api repos/<owner>/<repo>/security-advisories --jq '.[] | {ghsa_id, severity, summary, published_at}'

# 最近のリリース (現在 → 最新の間に何があったか)
gh api "repos/<owner>/<repo>/releases?per_page=10" --jq '.[] | {tag: .tag_name, published_at, body: (.body|.[0:300])}'

# 最近の Issue (security / malware / compromise / supply chain ラベルや言及)
gh search issues --repo <owner>/<repo> --state all --limit 10 \
  "security OR malware OR compromised OR \"supply chain\" OR hijack OR backdoor"
```

`gh` が失敗する (private / rate limit / 認証切れ) 場合は WebFetch で `https://github.com/<owner>/<repo>` を取り、リポジトリ説明・最終コミット・Star/Fork・"unmaintained" や "deprecated" の表示を読み取る。

#### Advisory 詳細を取りに行くべき場面

該当 Advisory が見つかったら、詳細を取って **patched_versions** と **vulnerable_version_range** を必ず確認する:

```bash
gh api repos/<owner>/<repo>/security-advisories/<ghsa_id> \
  --jq '{summary, severity, cve_id, vulnerabilities, published_at}'
```

- `patched_versions` に具体的なバージョンが入っている → 現在/最新が修正版かどうかを判定できる
- `patched_versions` が **空文字列** で `vulnerable_version_range` が「以上」だけになっている場合: 「修正がまだ入っていない」可能性と「メンテナーが GitHub UI に書き忘れている」可能性のどちらか。判別するには
  1. 該当リポジトリの Issue/PR を `gh search issues --repo <repo> "<ghsa_id>"` で検索
  2. 直近のリリースノートに該当 CVE 番号や advisory のキーワードが出ていないか確認
  3. それでも分からなければレポートに「修正状況の判別不可」と素直に書く

#### GitHub Release を作っていない upstream の場合

`gh api repos/.../releases/tags/<tag>` が 404 を返すリポジトリ (ansible、aws-cli など、Release Pages を使わずタグだけ運用するスタイル) は珍しくない。その場合のフォールバック:

1. リポジトリのルートに `CHANGELOG.md` / `CHANGELOG.rst` / `HISTORY.md` などがないか `gh api repos/<owner>/<repo>/contents` で確認
2. あれば `gh api repos/<owner>/<repo>/contents/CHANGELOG.md?ref=<tag>` で該当タグ時点のファイル内容を取得し、現在 → 最新間のセクションを読む
3. それでも見当たらなければ、タグ間の commit message 一覧で代用:
   ```bash
   gh api "repos/<owner>/<repo>/compare/<current_tag>...<latest_tag>" \
     --jq '.commits[] | {sha: .sha[0:8], message: (.commit.message | split("\n")[0])}'
   ```

### Web 上の警告調査

新しい話題 (CVE 番号、@user の警告、HN/Reddit/X での発覚) は GitHub には載らないことが多い。Advisory に載るより SNS/ニュース速報のほうが先行する事件パターンも実在する (2026 年の Shai-Hulud 系 npm 攻撃は初動コミュニティ報告が GH Advisory より早かった)。ただし全パッケージを個別に WebSearch するとコストが高いので、**仮判定** に基づいてクエリの粒度を分ける:

- **HIGH/MEDIUM の仮判定が出ているもの** (Advisory あり / 新顔メンテナーがリリース切ってる / 移管直後など): パッケージごとに個別クエリで深掘り
  - `"<package-name>" supply chain attack <year>`
  - `"<package-name>" malicious`
  - `"<package-name>" CVE-`
  - `"<owner>/<repo>" compromised`

- **LOW 仮判定のもの**: 集約クエリ 1 本で一括チェック (ヒット 0 なら全部「警告なし」と宣言できる)
  - `"<pkg1>" OR "<pkg2>" OR ... supply chain attack <year>`
  - 集約クエリで何かヒットしたら、該当パッケージだけ個別クエリに格上げして再調査

ヒット件数が 0 件であることはレポートにもはっきり言語化する (「特に警告は見つからず」)。逆にヒットがあれば、年月日とソース URL を必ず控える。

### メンテナー変更の確認

最近のリリースのコミット作者を見て、過去1年で新しい maintainer (これまでこのリポジトリに commit していなかった人) がリリースを切っていないかを確認する:

```bash
gh api "repos/<owner>/<repo>/commits?since=$(date -u -v-30d +%Y-%m-%d)T00:00:00Z&per_page=30" \
  --jq '[.[].author.login] | unique'
```

新顔がいきなり release タグを切っているのは要注意。

### スキップ条件

以下に該当する場合は重い調査を省略してよい:

- 同じ owner で連番のパッチアップデート (e.g. `v1.2.3` → `v1.2.4`) かつ Security Advisory なし → 「軽微」として1行で済ませる
- Homebrew の core formula で homepage が `https://www.gnu.org/...` や `https://nodejs.org/...` のような長年運用される公式サイト → メンテナンス指標は省略してよい

## Step 3: レポート出力

レポートは `.claude_work/supply-chain-audit/YYYY-MM-DD-HHMM/report.md` に保存する。ディレクトリは事前に作成する。

レポートの構造は **必ず** 以下のテンプレートに従う:

```markdown
# Supply Chain Audit Report — YYYY-MM-DD HH:MM

## Summary

| Risk      | Count | Packages      |
| --------- | ----- | ------------- |
| 🔴 HIGH   | N     | pkg-a, pkg-b  |
| 🟡 MEDIUM | N     | pkg-c         |
| 🟢 LOW    | N     | (省略 / N 件) |

**推奨アクション**: 1〜2行で結論。「HIGH があるので X は保留、他は更新可」など。

## Risk levels

- 🔴 **HIGH**: Security Advisory が公開済、CVE がアサインされている、メンテナー乗っ取り報告あり、SNS で具体的な被害報告あり
- 🟡 **MEDIUM**: 関連 Issue で懸念表明あり、過去30日以内に新規メンテナーがリリースを切っている、突然のリポジトリ移管、長期間更新停止からの大型コミット
- 🟢 **LOW**: 公開情報に懸念見当たらず。通常通り更新してよい

## Findings

### Homebrew

#### 🔴/🟡/🟢 <formula-name>: <current> → <latest>

- **Repo**: <github URL>
- **Advisory**: <ghsa link or "なし">
- **Recent maintainers (30d)**: <login list or "no change">
- **Web mentions**: <最新の懸念ある記事 or "特に警告なし">
- **Notes**: <release notes の重要点を1-2行>

(以下、cask / mas / Neovim プラグインを同形式で続ける)

## 補足

- 調査済みの公開情報源と日付
- 確認できなかった項目 (rate limit などで取れなかった情報) は正直に書く
```

### レポート作成上の注意

- **断定しすぎない**: 「公開情報からは懸念なし」と書く。コード本体まで読んだわけではないので「安全」とは言わない。
- **取れなかった情報は隠さない**: `gh` が rate limit に当たって調査できなかった項目は素直に書く。
- **見つかった具体的な日付・コミット・URL は必ず引用**: 後でユーザーがダブルチェックできるように。
- **更新コマンドは絶対に実行しない**: レポートの最後で「更新する場合は次のコマンドを手動で実行してください」と提示するに留める。

## 出力後の振る舞い

レポート保存後、ユーザーに以下を伝える:

1. レポートの保存パス
2. HIGH/MEDIUM 件数 (件数だけ、詳細はレポートを読んでもらう)
3. 「これを見てから更新を進めてください。ご自身で `brew upgrade <pkg>` などを実行する形になります」

ユーザーが「じゃあ更新して」と明示的に言うまで、更新コマンドは絶対に実行しない。
