# My Dotfiles

These are my configuration files for [Fish Shell](https://fishshell.com/) and [Neovim](https://github.com/neovim/neovim).

This is intentionally minimal: you get a decently productive setup with minimal effort.

## Neovim

This config is based on [this](https://github.com/LunarVim/nvim-basic-ide) starting point.

### Setup

Install Neovim > 0.8 and copy the `nvim` folder to `~/.config/`.

[Appimages](https://github.com/neovim/neovim/wiki/Installing-Neovim#appimage-universal-linux-package) are a convenient way to install Neovim. Here's a quick script to set this up:
```bash
# WARNING: will remove the existing nvim.appimage file in TGT_DIR if present
# Note: TGT_DIR should be in your PATH

TGT_DIR="$HOME/.local/bin/"
NVIM_VERSION="v0.8.1"
DL_URL=https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}

cd "$TGT_DIR"

wget ${DL_URL}/nvim.appimage.sha256sum -q -O  nvim.appimage.sha256sum
wget ${DL_URL}/nvim.appimage -q -O nvim.appimage

PROCEED="$(sha256sum -c nvim.appimage.sha256sum)"

if [[ $PROCEED =~ "OK" ]]; then
    echo "Checksum OK"
    chmod u+x nvim.appimage
    ln -sf nvim.appimage nvim
else
    echo "Checksum Failed"
    rm nvim.appimage
fi
```


## Fish Config

I'm using [Fisher](https://github.com/jorgebucaran/fisher) as a plugin manager for Fish and the [Tide](https://github.com/IlanCosman/tide) theme which already provides a lot of functionality out of the box.

My only addition is to alias [Exa](https://github.com/ogham/exa) as a (slightly) better ls.

### Setup

Install Fish + Fisher + Tide and copy the `config.fish` file to `~/.config/fish/`.

For example on Ubuntu based systems:

```bash
# install fish
sudo apt-add-repository ppa:fish-shell/release-3
sudo apt update
sudo apt install fish exa

chsh -s /usr/bin/fish

# install fisher
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

# install tide
fisher install IlanCosman/tide@v5
```
