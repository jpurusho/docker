#!/bin/zsh

#Install oh-my-zsh
test ! -d dev/dotfiles && mkdir -p $_
test -f zshrc && cp $_ .zshrc
test -f zsh-prompt.sh && cp $_ dev/dotfiles
test -f zshrc && cp $_ dev/dotfiles
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone https://github.com/amix/vimrc.git ~/.vim_runtime && /bin/sh ~/.vim_runtime/install_awesome_vimrc.sh
test -f dev/dotfiles/zshrc && cp $_ .zshrc
test -f zshrc && rm -f $_
test -f zsh-prompt.sh && rm -f $_