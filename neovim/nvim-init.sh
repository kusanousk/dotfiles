#!/bin/bash

DIR="$(cd $(dirname $0); pwd)"

# init.vimのシンボリックリンク作成
if [ ! -e "$HOME/.config/nvim/init.vim" ]; then
    mkdir -p $HOME/.config/nvim
    ln -s $DIR/init.vim $HOME/.config/nvim/init.vim
fi

# install vim-plug
if [ ! -e "$HOME/.local/share/nvim/site/autoload/plug.vim" ]; then
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
