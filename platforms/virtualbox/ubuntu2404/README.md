# VirtualBox Ubuntu 24.04 Development Environment

VirtualBox + Vagrant を使用した Ubuntu 24.04 開発環境のプロビジョニング設定です。

## 概要

このディレクトリには、WSL2 と同等の開発環境を VirtualBox VM 上に構築するための設定が含まれています。

- **OS**: Ubuntu 24.04
- **リソース**: 4GB RAM, 4 CPU
- **プロビジョニング**: setup_wsl2.sh 相当の環境構築
- **dotfiles**

## 前提条件

### macOS ホスト要件

- **VirtualBox**: 7.0 以降が必要（Apple Silicon で ARM ゲストをサポート）
- **Vagrant**: 最新版を推奨

バージョン確認:

```bash
VBoxManage --version  # 7.0.0 以上であることを確認
vagrant --version
```

VirtualBox 7.0 未満の場合は、[公式サイト](https://www.virtualbox.org/)から最新版をダウンロードしてください。

## 使い方

### 1. VM の起動とプロビジョニング

```bash
cd ~/dotfiles/platforms/virtualbox/ubuntu2404
vagrant up
```

初回起動時は以下が自動実行されます（15-30分程度）:

- Ubuntu 24. 04のダウンロードと起動(ホストに応じて自動でアーキテクチャが選択される)
- パッケージのインストール（gcc, python, node, rust, go など）
- 開発ツールのインストール（nvim, starship, pyenv, rbenv, tfenv など）
- dotfiles リポジトリのクローン
- 設定ファイルのシンボリックリンク作成

### 2. VM への SSH 接続

```bash
vagrant ssh
```

### 3. 初回セットアップ後の設定

#### Git ユーザー情報の設定

```bash
vim ~/.gitconfig.local
```

以下の内容を追加:

```ini
[user]
  name = YOUR_NAME
  email = YOUR_EMAIL
```

#### tmux プラグインのインストール

```bash
tmux
# Ctrl-t I を押してプラグインをインストール
```

#### シェル設定の反映

```bash
source ~/.bashrc
```

### 4. VM の操作

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

## カスタマイズ

### VM リソースの変更

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

### 追加パッケージのインストール

`provision.sh` の該当セクションに追加:

```bash
# 2. Install development and utility packages
sudo apt install -y \
  # ... 既存のパッケージ ...
  your-package-name
```

変更後:

```bash
vagrant provision
```
