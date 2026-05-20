# nvim

## lazy-lock.json の運用

`lazy-lock.json` で全プラグインの commit SHA を固定する。

### 通常運用

`:Lazy update` 実行後は dotfiles 側に diff が出るので、内容を確認してからコミットする。

```bash
cd ~/dotfiles
git diff common/nvim/lazy-lock.json
git add common/nvim/lazy-lock.json
git commit -m "update nvim plugin lock"
```

### 別マシンでのセットアップ

`setup_nvim.sh` 実行後、Neovim を起動して `:Lazy restore` を実行すると lock ファイルに記録された commit に揃う。

```bash
sh ~/dotfiles/common/nvim/setup_nvim.sh
nvim +Lazy\ restore
```

### 怪しい更新を検出した場合

`:Lazy update` の diff レビューで怪しい変更を見つけたら、該当プラグインのエントリだけ `lazy-lock.json` で手動で以前の SHA に書き戻し、`:Lazy restore` で適用する。

```bash
# 直前のコミットの該当エントリを確認
git show HEAD:common/nvim/lazy-lock.json | jq '."plugin-name"'

# lazy-lock.json を手動編集して前の SHA に戻す
# その後 nvim 内で :Lazy restore
```
