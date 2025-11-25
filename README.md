# dotfiles

## Setup

Clone this repository with submodules:

```bash
git clone --recurse-submodules https://github.com/N0nki/dotfiles.git
```

If you've already cloned without submodules:

```bash
cd ~/dotfiles
git submodule init
git submodule update
```

## Update Submodules

To update submodules to their latest versions:

```bash
cd ~/dotfiles
git submodule update --remote common/fzf-git
git add common/fzf-git
git commit -m "update fzf-git submodule"
```
