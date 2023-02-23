#!/bin/bash

sudo pacman -S yubikey-personalization gnupg yubikey-manager-qt --noconfirm

sudo echo 'export GPG_TTY="$(tty)"' | sudo tee -a /etc/profile
sudo echo 'gpg-connect-agent updatestartuptty /bye' | sudo tee -a /etc/profile
sudo echo 'export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"' | sudo tee -a /etc/profile
