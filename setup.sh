#!/bin/bash

# install vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

pip install --upgrade pip pylint autoflake isort 
# for my config in Neovim
pip install --upgrade setuptools pyright autopep8 pynvim debugpy

# Install latest nodejs
if [ ! -x "$(command -v node)" ]; then
    curl --fail -LSs https://install-node.now.sh/latest | sh
    export PATH="/usr/local/bin/:$PATH"
fi

sudo npm install -g neovim eslint pyright vscode-cpptools 

nvim -E -s dummy.out << EOF
:PlugInstall
EOF
