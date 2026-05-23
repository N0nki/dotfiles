# Homebrew (formula / cask) の調査手順

更新候補は `brew outdated --formula --json=v2` と `brew outdated --cask --json=v2` で取れる。`scripts/list_pending_updates.sh` が両方を呼んでいる。

ここから先は「各候補の GitHub リポジトリ (または upstream) に着地して、公開情報の警告サインを確認する」フェーズ。

## 候補ごとの調査ステップ

### 1. upstream リポジトリ URL を取得する

```bash
brew info --json=v2 <name> | jq -r '.formulae[0] | {homepage, urls: .urls.stable.url, head: .urls.head.url, tap}'
brew info --cask --json=v2 <name> | jq -r '.casks[0] | {homepage, url, name}'
```

- `homepage` が `https://github.com/<owner>/<repo>` 形式なら、それが調査対象。
- そうでなければ `urls.stable.url` (tarball URL) からホストを判定する。GitHub release のアセットだったら `<owner>/<repo>` を URL から抜き出す。
- cask の `url` は配布元 (例: `https://download.mozilla.org/...`)。GitHub でない場合は、ベンダー公式サイトのリリースノートを WebFetch する。

GitHub に着地できないケース (公式サイト直配布の cask 等) は、ベンダー公式のリリースノート URL を WebFetch して「最近の変更が異常なほど大きくないか」「sign keyの変更が告知されていないか」だけを軽く確認する。

### 2. GitHub Security Advisory を見る

```bash
gh api repos/<owner>/<repo>/security-advisories \
  --jq '.[] | {ghsa_id, severity, summary, published_at, html_url}' 2>/dev/null
```

- 空配列なら HIGH 認定の要素なし。
- `severity` が `critical` または `high` のものがあれば即 🔴 HIGH に分類。`published_at` が直近 (現在 → 最新更新の期間中) なら特に重要。

ヒットがあれば、必ず詳細を取って `patched_versions` を確認:

```bash
gh api repos/<owner>/<repo>/security-advisories/<ghsa_id> \
  --jq '{summary, severity, cve_id, vulnerabilities, published_at}'
```

判定の落とし穴: **`patched_versions` が空文字列 (`""`)** で返ってくることがある。これは「修正未リリース」か「メンテナーが GitHub UI に書き忘れただけ」のどちらか:

- 「現在使用中のバージョン」が `vulnerable_version_range` に含まれているなら、今回の更新で脆弱性が解消されないままになる可能性がある (HIGH advisory ならレポートで MEDIUM 以上に格上げ)
- 修正済かどうかを確実に知るには:
  1. `gh search issues --repo <owner>/<repo> "<ghsa_id> OR <cve_id>"` で関連 PR/Issue を探す
  2. 直近リリースノートに CVE 番号や advisory 名が出ていないか
  3. 不明なら正直に「修正状況の判別不可」とレポートに書く

`gh api` が `Could not resolve to a Repository` で返ってきた場合は、リポジトリ名が変わっている可能性 (rename) がある。`gh api repos/<owner>/<repo>` で 301 が出るか確認し、redirect 先で再試行する。リポジトリ移管そのものが要注意シグナル。

### 3. 該当バージョン周辺のリリースを読む

```bash
# 現在バージョン → 最新バージョン間のリリースをざっと取得
gh api "repos/<owner>/<repo>/releases?per_page=20" \
  --jq '.[] | select(.draft|not) | {tag: .tag_name, published_at, author: .author.login, body: (.body|.[0:400])}'
```

ansible や aws-cli のように GitHub Release を作らない (タグだけ運用する) リポジトリでは `releases/tags/<tag>` が 404 を返す。その場合のフォールバック:

```bash
# 案 A: リポジトリ内の CHANGELOG を該当タグ時点で読む
gh api "repos/<owner>/<repo>/contents/CHANGELOG.md?ref=<tag>" --jq '.content' | base64 -d | head -200

# 案 B: 現在タグ → 最新タグ間のコミットメッセージ一覧
gh api "repos/<owner>/<repo>/compare/<current_tag>...<latest_tag>" \
  --jq '.commits[] | {sha: .sha[0:8], author: .author.login, message: (.commit.message | split("\n")[0])}'
```

`CHANGELOG.rst` / `HISTORY.md` / `docs/CHANGELOG.md` などプロジェクトごとに名前が違うため、まず `gh api repos/<owner>/<repo>/contents` でルート直下のファイル一覧を見て当たりをつけるとよい。

注目点:

- リリース author が **これまで release を切ったことがない login** に変わっていないか
- リリースノートに `dependency`, `sign`, `key`, `maintainer`, `transfer` などのキーワードがあるか
- 通常のパッチアップデートのテンポと比べて、突然 major リリースが連発していないか

### 4. メンテナー変更を確認する

過去 30 日のコミット author を unique 集計:

```bash
SINCE=$(date -u -v-30d +%Y-%m-%dT%H:%M:%SZ)
gh api "repos/<owner>/<repo>/commits?since=${SINCE}&per_page=100" \
  --jq '[.[].author.login // .commit.author.name] | unique'
```

- このリポジトリの過去の主要 contributor と照合して、ここ 30 日に新顔がいないかを見る。
- 新顔が出ること自体は普通だが、**新顔がいきなりリリースを切っている** 場合は 🟡 MEDIUM に分類して理由を書く。

### 5. セキュリティ系 Issue/PR の検索

```bash
gh search issues --repo <owner>/<repo> --state all --limit 15 \
  "security OR malware OR compromised OR \"supply chain\" OR hijack OR backdoor OR exfiltrat" \
  --json title,url,createdAt,state
```

ヒットがあれば内容を 1 件ずつ確認 (`gh issue view <num> --repo <owner>/<repo>`)。直近で open になっているもの、または closed でも reaction が多いものは要チェック。

### 6. Web 上の警告調査

GitHub に出ていない外部告発を拾うフェーズ。SKILL.md の本筋ルール (LOW は集約 1 クエリ / HIGH・MEDIUM 仮判定は個別深掘り) に従って粒度を調整する。

HIGH/MEDIUM 候補に対して使う個別クエリ:

- `"<package-name>" supply chain attack <year>`
- `"<package-name>" malicious npm OR brew`
- `"<owner>/<repo>" compromised`
- `CVE <package-name> <year>`

LOW 候補に対しては集約クエリで一括スキャン (`<year>` は現在年):

- `"<pkg1>" OR "<pkg2>" OR ... supply chain attack <year>`
- 0 件ならレポートで「LOW 候補全件について Web 上の警告は見つからず」と一括で書ける
- ヒットがあれば該当パッケージを HIGH/MEDIUM 候補に格上げして再調査

HN/Reddit/X や ZDNet/BleepingComputer/TheHackerNews などの記事が引っかかれば、必ず URL と日付を控える。

## 判定の目安

| 観察結果                                                                                               | 分類      |
| ------------------------------------------------------------------------------------------------------ | --------- |
| Advisory critical/high あり、または CVE がアサインされている、または「○○がマルウェアになった」記事あり | 🔴 HIGH   |
| 新顔メンテナーがいきなり release を切った / リポジトリ移管直後 / Issue で複数人が懸念表明              | 🟡 MEDIUM |
| 同一 owner の連番パッチ更新で Advisory なし、Web 警告なし                                              | 🟢 LOW    |

## スキップ条件 (調査を軽くしてよい場合)

- Apple や Google などのベンダー直配布 cask (例: Google Chrome) で、homepage がベンダー公式ドメイン → Security Advisory はベンダーのページから探す。GitHub 調査はスキップ可。
- Homebrew core の長期運用 formula (例: `git`, `coreutils`, `openssl`) で minor バージョン上げのみ → Advisory チェックだけで終了してよい。

## 共通 jq テクニック

```bash
# 複数 formula を一気に処理
for pkg in ansible awscli mise; do
  echo "=== $pkg ==="
  brew info --json=v2 "$pkg" | jq -r '.formulae[0] | .homepage'
done
```

GitHub URL のパースは sed/awk より jq の URL 整形のほうが楽:

```bash
brew info --json=v2 <name> \
  | jq -r '.formulae[0].homepage' \
  | sed -E 's#https?://github.com/([^/]+/[^/]+)/?.*#\1#'
```
