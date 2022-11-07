#!/bin/zsh

# OhMyZsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Antigen
curl -L git.io/antigen > antigen.zsh

# Neovim

## Making sure we get a fresh copy of latest Neovim
echo "Installing Neovim."
NVIM_VERSION="0.7.0"
wget "https://github.com/neovim/neovim/releases/download/v${NVIM_VERSION}/nvim-linux64.deb"
sudo apt install -y ./nvim-linux64.deb && rm ./nvim-linux64.deb

## Config
mkdir -p ~/.config
mkdir -p ~/.config/kitty

# Nice shell colors
git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell

# Linking files
# ln -sf ~/shopify-dotfiles/nvim/ ~/.config/nvim
ln -sf ~/code/dotfiles/zshrc ~/.zshrc
ln -sf ~/code/dotfiles/antigenrc ~/.antigenrc
ln -sf ~/code/dotfiles/gitconfig ~/.gitconfig
ln -sf ~/code/dotfiles/tmux.conf ~/.tmux.conf
ln -sf ~/code/dotfiles/kitty.conf ~/.config/kitty/kitty.conf

# Some of these tools need config files in place to modifiy them that is why
# we put them here.

# Starship
echo "Installing starship."
sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --force

# fzf
echo "Installing fzf."
if ! command -v fzf &> /dev/null; then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install --all
fi

echo "Neovim packer bootstrap..."
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
