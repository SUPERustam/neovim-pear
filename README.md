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
- [ ] Compelete documentation
- [ ] Fix NerdTree
- [ ] Moving lines in file: https://stackoverflow.com/questions/741814/move-entire-line-up-and-down-in-vim:complete
- [ ] Figure out coc.nvim shortcuts
- [ ] Full support of debugger
- [ ] Move from Ctrl to something else
