# Install
1. Install [Neovim](https://github.com/neovim/neovim/blob/master/INSTALL.md)
2. Setup packages
```sh
mkdir -p  ~/.config/nvim
git clone https://github.com/SUPERustam/neovim-pear.git ~/.config/nvim/
cd ~/.config/nvim
./setup.sh
```
3. In Neovim, install all packages
```vimscript
:PlugInstall
```

# TODO:
- [ ] Fix NerdTree
- [ ] Moving lines in file: https://stackoverflow.com/questions/741814/move-entire-line-up-and-down-in-vim:complete
- [ ] Figure out coc.nvim shortcuts
- [ ] Full support of debugger
- [ ] Use Ctrl for linux/windows, command for macos
- [ ] Format py, bash, toml, yaml, json files
- [ ] Search files, names (maybe use https://github.com/dmtrKovalenko/fff)
- [ ] File system tree
- [ ] Easy work mamba/conda
- [ ] Support for ssh remote machines
