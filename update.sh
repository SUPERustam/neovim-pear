set -eu

NVIM_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
NVIM_DATA="${XDG_DATA_HOME:-$HOME/.local/share}/nvim"

echo "==> Updating Neovim"
if command -v brew >/dev/null 2>&1; then
  brew update
  brew upgrade neovim || brew install neovim
elif command -v apt-get >/dev/null 2>&1; then
  sudo apt-get update
  sudo apt-get install -y neovim
elif command -v dnf >/dev/null 2>&1; then
  sudo dnf upgrade -y neovim || sudo dnf install -y neovim
elif command -v pacman >/dev/null 2>&1; then
  sudo pacman -Syu --needed neovim
else
  echo "No supported package manager found. Update Neovim manually:"
  echo "https://github.com/neovim/neovim/blob/master/INSTALL.md"
fi

echo "==> Updating this config"
if [ -d "$NVIM_CONFIG/.git" ]; then
  git -C "$NVIM_CONFIG" pull --rebase --autostash
else
  echo "Config repo not found at $NVIM_CONFIG; skipping git update."
fi

echo "==> Updating vim-plug"
curl -fLo "$NVIM_DATA/site/autoload/plug.vim" --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "==> Updating Python support"
python3 -m pip install --upgrade pip setuptools pynvim ruff ty
if command -v mamba >/dev/null 2>&1; then
  mamba install -n base -y pynvim
fi

echo "==> Updating Node support"
if command -v npm >/dev/null 2>&1; then
  npm install -g neovim eslint prettier
else
  echo "npm is not installed; skipping Node package updates."
fi

echo "==> Updating formatter/search CLIs"
if command -v brew >/dev/null 2>&1; then
  brew install fd taplo shfmt
  brew tap macos-fuse-t/homebrew-cask
  brew install fuse-t
  brew install fuse-t-sshfs
fi

echo "==> Updating Vim plugins and CoC extensions"
nvim --headless +'PlugUpgrade' +'PlugUpdate --sync' +'CocUpdateSync' +qa

echo "==> Done"
