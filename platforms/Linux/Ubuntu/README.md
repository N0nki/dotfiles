# Linux Ubuntu Development Environment Setup

WSL2 と VirtualBox 向けの Ubuntu 開発環境セットアップスクリプトです。

## ファイル構成

```
platforms/Linux/Ubuntu/
├── setup.sh      # 統合セットアップスクリプト
├── .bashrc       # 統合 .bashrc（プラットフォーム自動判定）
└── README.md     # このファイル
```

## 使い方

### WSL2 での使用

```bash
git clone "https://github.com/N0nki/dotfiles
cd ~/dotfiles
git pull
sh ~/dotfiles/platforms/Linux/Ubuntu/setup.sh
```

### VirtualBox (Vagrant) での使用

#### 前提条件

- **VirtualBox**: 7.0 以降が必要（Apple Silicon で ARM ゲストをサポート）
- **Vagrant**: 最新版を推奨

バージョン確認:

```bash
VBoxManage --version  # 7.0.0 以上であることを確認
vagrant --version
```

#### VM の起動とプロビジョニング

```bash
# Vagrant 経由で自動実行
cd ~/dotfiles/platforms/Linux/Ubuntu
vagrant up
```

#### VM への SSH 接続

```bash
vagrant ssh
```

#### VM の操作

```bash
# VM の停止
vagrant halt

# VM の再起動
vagrant reload

# VM の削除（完全に削除）
vagrant destroy

# VM の状態確認
vagrant status

# プロビジョニングのみ再実行
vagrant provision
```

#### VM リソースのカスタマイズ

`Vagrantfile` を編集:

```ruby
config.vm.provider "virtualbox" do |vb|
  vb.memory = "8192"  # メモリを8GBに増やす
  vb.cpus = 8         # CPUを8コアに増やす
end
```

変更後:

```bash
vagrant reload
```

### その他の Ubuntu 環境での使用

```bash
# EC2, Docker, 物理マシンなど
git clone --recurse-submodules https://github.com/N0nki/dotfiles.git ~/dotfiles
sh ~/dotfiles/platforms/Linux/Ubuntu/setup.sh
```

## セットアップ後の設定

### 1. Git ユーザー情報の設定

```bash
vim ~/.gitconfig.local
```

以下を追加：

```ini
[user]
  name = YOUR_NAME
  email = YOUR_EMAIL
```

### 2. tmux プラグインのインストール

```bash
tmux
# Ctrl-t I を押してプラグインをインストール
```

### 3. シェル設定の反映

```bash
source ~/.bashrc
```
