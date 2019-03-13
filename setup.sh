#!/bin/bash

# cleanup
if [ -f ~/.vimrc ]; then
    rm ~/.vimrc
fi

for var in $*
do
    if [ "$var" = "-r" ];  then
        rm -rf ~/.vim
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        rm -rf ~/.vim/colors
        mkdir ~/.vim/colors
    fi
done

cp .vimrc ~/.vimrc
cp ./vimrc.bundle ~/.vim/vimrc.bundle
if [ -f "./vimrc.additional.bundle" ]; then
    cp ./vimrc.additional.bundle ~/.vim/vimrc.additional.bundle
fi

vim -E -s <<-EOF
:source ~/.vimrc
:qa
EOF
vim +PlugInstall +qall

cp ./snippets/* ~/.vim/plugged/vim-snippets/snippets

