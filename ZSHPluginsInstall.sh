#!/usr/bin/env bash

###############################################################################
# ERROR: Let the user know if the script fails
###############################################################################

trap 'ret=$?; test $ret -ne 0 && printf "\n   \e[31m\033[0m  Formation failed  \e[31m\033[0m\n" >&2; exit $ret' EXIT

set -e

###############################################################################
# TWIRL: Check for required functions file
###############################################################################

if [ -e twirl ]; then
	cd "$(dirname "${BASH_SOURCE[0]}")" \
		&& . "twirl"
else
	printf "\n ⚠️  ./twirl not found  💃🏾 First, you need to twirl on your haters\n"
	exit 1
fi

###############################################################################
# OPTIONAL: oh-my-zsh
###############################################################################
chapter "installing oh-my-zsh plugins…"

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
sed -i -e 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc
source ~/.zshrc

chapter "Installing oh-my-zsh plugins success!"
