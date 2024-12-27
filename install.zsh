#!/bin/sh

START_PATH=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

########

echo "Setup Env"

cd /etc/default
sudo ln -s "$START_PATH/default/keyboard" .
cd ~/
ln -s "$START_PATH/basic/clang-format" .clang-format
ln -s "$START_PATH/basic/vimrc" .vimrc

exit

########

echo "Setup Config Files"

mkdir -p ~/.config
cd ~/.config

ln -s "$START_PATH/i3/" .
ln -s "$START_PATH/i3status/" .
ln -s "$START_PATH/kitty/" .
ln -s "$START_PATH/nvim/" .
ln -s "$START_PATH/picom/" .
ln -s "$START_PATH/zellij/" .
ln -s "$START_PATH/ghostty/" .

cd ~/

########

echo "Setup Zsh"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

cd ~/.oh-my-zsh/custom/plugins/
ln -s "$START_PATH/zsh/plugins/zsh-autosuggestions" zsh-autosuggestions

cd ~/
rm -rf .zshrc
ln -s "$START_PATH/zsh/zshrc" .zshrc

########
