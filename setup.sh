#!/bin/bash

# install vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

pip3 install --upgrade pip  
# for my config in Neovim
pip3 install --upgrade setuptools pynvim ruff ty

if [ -x "$(command -v mamba)" ]; then
    mamba install -n base -y pynvim
fi

# Install latest nodejs
if [ ! -x "$(command -v node)" ]; then
    curl --fail -LSs https://install-node.now.sh/latest | sh
    export PATH="/usr/local/bin/:$PATH"
fi

sudo npm install -g neovim eslint prettier

if [ -x "$(command -v brew)" ]; then
    brew install fd taplo shfmt
    brew tap macos-fuse-t/homebrew-cask
    brew install fuse-t
    brew install fuse-t-sshfs
fi

nvim -E -s dummy.out << EOF
:PlugInstall
:CocCommand clangd.install
EOF
