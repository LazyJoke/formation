#!/bin/bash
set -u
if [[ "$(uname -s)" == "Linux" ]]; then BREW_TYPE="linuxbrew"; else BREW_TYPE="homebrew"; fi
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/${BREW_TYPE}-core.git"

git clone --depth=1 https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/install.git brew-install
/bin/bash brew-install/install.sh
rm -rf brew-install

BREW_TAPS="$(brew tap)"
for tap in core cask{,-fonts,-drivers,-versions} command-not-found; do
    if echo "$BREW_TAPS" | grep -qE "^homebrew/${tap}\$"; then
        # 将已有 tap 的上游设置为本镜像并设置 auto update
        # 注：原 auto update 只针对托管在 GitHub 上的上游有效
        git -C "$(brew --repo homebrew/${tap})" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-${tap}.git
        git -C "$(brew --repo homebrew/${tap})" config homebrew.forceautoupdate true
    else   # 在 tap 缺失时自动安装（如不需要请删除此行和下面一行）
        brew tap --force-auto-update homebrew/${tap} https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-${tap}.git
    fi
done

brew update-reset
