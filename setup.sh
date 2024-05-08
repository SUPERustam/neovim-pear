#!/bin/bash

# install vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

pip3 install --upgrade pip  
# for my config in Neovim
pip3 install --upgrade setuptools pynvim debugpy

# Install latest nodejs
if [ ! -x "$(command -v node)" ]; then
    curl --fail -LSs https://install-node.now.sh/latest | sh
    export PATH="/usr/local/bin/:$PATH"
fi

sudo npm install -g neovim eslint vscode-cpptools 

nvim -E -s dummy.out << EOF
:PlugInstall
:CocCommand clangd.install
EOF
