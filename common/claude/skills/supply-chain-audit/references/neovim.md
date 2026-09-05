# Neovim プラグイン (lazy.nvim) の調査手順

Neovim プラグインはほぼすべて GitHub 配信の Lua/Vimscript で、postinstall でビルドが走るもの (treesitter parser, telescope-fzf-native など) もある。`require()` 経由でユーザーマシン上の任意のコードを実行できるため、悪意のあるバージョンが入ったら被害は大きい。

## 更新候補のリストアップ

このリポジトリでは `common/nvim/lazy-lock.json` がプラグインのバージョンを固定している。**`.lazy-lock.json` の git diff = これから入れようとしている更新の中身**。

```bash
# dotfiles リポジトリで diff を確認
git -C ~/dotfiles --no-pager diff -- common/nvim/lazy-lock.json
```

差分が出ていない (= まだ `:Lazy sync` 等を走らせていない) 場合は、Neovim を起動して `:Lazy check` で確認するか、ヘッドレスで:

```bash
nvim --headless '+Lazy! check' '+qa'
```

実行後、再度 `git diff` を見ると更新候補が lazy-lock.json に反映されている。

## diff の読み方

lazy-lock.json は次のような構造:

```json
{
  "plenary.nvim": { "branch": "master", "commit": "abc1234..." }
}
```

更新があるとそのプラグインの `commit` フィールドが書き換わる。古いコミットと新しいコミットの差を確認することが調査の中心になる。

## プラグイン名から GitHub repo を解決する

lazy-lock.json には `owner/repo` 形式ではなく **プラグイン名** (リポジトリ名のみ) が記録されている。owner は `common/nvim/lua/plugins.lua` から引く:

```bash
# プラグイン名から owner/repo を逆引き
grep -E '"\w+/<plugin-name>"' ~/dotfiles/common/nvim/lua/plugins.lua
```

例: `plenary.nvim` → `grep '"\w+/plenary.nvim"'` → `nvim-lua/plenary.nvim` が出る。

複数の lua ファイルを横断したい場合:

```bash
rg -n '"\w+/<plugin-name>"' ~/dotfiles/common/nvim
```

## 候補ごとの調査ステップ

### 1. コミット範囲を取得する

```bash
OLD_COMMIT=<diff の左側のコミット>
NEW_COMMIT=<diff の右側のコミット>
gh api "repos/<owner>/<repo>/compare/${OLD_COMMIT}...${NEW_COMMIT}" \
  --jq '{ahead: .ahead_by, behind: .behind_by, commits: [.commits[] | {sha: .sha[0:8], author: .author.login, message: (.commit.message|.[0:120])}]}'
```

ここで見るべきポイント:

- **`ahead_by` がやたら大きい** (例: 3桁を超える) のに更新の意図が「軽微なバグ修正」と書かれている → 不自然
- **コミットの author に新顔がいる**
- **コミットメッセージに `signing`, `release`, `maintainer`, `key`, `obfuscat`, `loader` といった unusual な単語が頻出**

### 2. 差分の追加コードの傾向を見る

```bash
gh api "repos/<owner>/<repo>/compare/${OLD_COMMIT}...${NEW_COMMIT}" \
  --jq '.files[] | {filename, status, changes}'
```

異常サイン:

- 既存ファイルに **1コミットで巨大な追加** が入っている
- `init.lua` / `plugin/*.lua` / `lua/<plugin>/init.lua` のような起動時に走るファイルが書き換わっている
- `os.execute`, `io.popen`, `vim.fn.system`, `loadstring`, `vim.uv.spawn` といった外部実行や動的コード読み込みが追加されている (`gh api` の patch を眺めるか、`gh search code` で確認)

調査用 grep:

```bash
gh api "repos/<owner>/<repo>/compare/${OLD_COMMIT}...${NEW_COMMIT}" \
  --jq '.files[] | .patch' \
  | grep -E '\+\s*(os\.execute|io\.popen|vim\.fn\.system|vim\.uv\.spawn|loadstring|curl |wget )' \
  | head -50
```

ヒットがあれば、それぞれが正当な変更 (例: 既存機能の改修) か、新規に外部通信を増やしているのかを確認。

### 3. Security Advisory と Issue

Homebrew と同じく:

```bash
gh api repos/<owner>/<repo>/security-advisories --jq '.[] | {ghsa_id, severity, summary, published_at}'

gh search issues --repo <owner>/<repo> --state all --limit 10 \
  "security OR malware OR compromised OR \"supply chain\" OR hijack OR backdoor"
```

### 4. リポジトリの "ふつうさ" 確認

```bash
gh api repos/<owner>/<repo> --jq '{stars: .stargazers_count, archived, disabled, pushed_at, owner: .owner.login, fork, parent: (.parent.full_name // null)}'
```

- `archived: true` なのに lazy-lock.json で更新されようとしている → 通常ありえないので 🟡 以上
- `fork: true` で `parent` が別オーナー → そもそも fork を使っている設定が意図的かを確認 (たまにメンテナンス切れの本家から fork に乗り換えるパターンあり)
- `disabled: true` → 即 🔴

### 5. Web 上の警告調査

SKILL.md 本筋のルール (LOW は集約 1 クエリ / HIGH・MEDIUM 仮判定は個別深掘り) に従う。Neovim プラグインのサプライチェーン攻撃は他のエコシステム (npm/PyPI) より報道頻度が低いが、Reddit `/r/neovim` や HN で話題になることがある。

HIGH/MEDIUM 候補向け個別クエリ:

```
- "<owner>/<repo>" malicious
- "<owner>/<repo>" hijacked
- "neovim plugin" supply chain <year>
- "<plugin-name>" CVE
```

LOW 候補が大量にある (例: 20 件以上の bump) ときの集約クエリ:

```
- "<plugin1>" OR "<plugin2>" OR ... compromised OR malicious <year>
- ヒット 0 なら「LOW 候補全件について Web 上の警告なし」と一括宣言
```

ヒットがあった場合は該当プラグインだけ HIGH/MEDIUM 候補に格上げして個別深掘り。

## 判定の目安

| 観察結果                                                                                                                      | 分類      |
| ----------------------------------------------------------------------------------------------------------------------------- | --------- |
| Advisory critical/high あり、archived/disabled なのに更新が出てる、明確な乗っ取り報告                                         | 🔴 HIGH   |
| 大量の ahead commits / 新顔メンテナーが切ったリリース / 起動時実行ファイルに os.execute 系の新規追加 / repository transferred | 🟡 MEDIUM |
| 数コミットのバグ修正 + 既存メンテナー + Advisory なし                                                                         | 🟢 LOW    |

## スキップ条件

- **公式 neovim org のプラグイン** (`neovim/nvim-lspconfig`, `nvim-lua/plenary.nvim`, `nvim-treesitter/*`, `nvim-telescope/*` など)、**Treesitter Parser リポジトリ** (`tree-sitter/tree-sitter-*`)、**広く使われている著名プラグイン** で、現在コミットから最新コミットまでの差が小さい場合 (たとえば10コミット以下) は Advisory チェックだけで終了してよい。
- 自分が pin している commit からの ahead が 0 や 1 の場合は LOW 確定。

## まとめて処理するときのテンプレ

差分対象のプラグインが多い場合、まず lazy-lock.json の diff からプラグイン名一覧を抽出してループする:

```bash
git -C ~/dotfiles diff -- common/nvim/lazy-lock.json \
  | grep -E '^\s*"[^"]+":' \
  | sed -E 's/^\s*"([^"]+)".*/\1/' \
  | sort -u
```

そのリストをもとに、上の手順を1プラグインずつ実行していく。20件を超える更新があるときは「全部一気には深掘りしない、まず Advisory チェックだけ全件回して引っかかったものだけ深掘りする」というふうに段階を踏むのがおすすめ。
