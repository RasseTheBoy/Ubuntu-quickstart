#!/bin/bash

# Nala Install
upd_ni () {
    sudo nala update
    sudo nala install -y "$@"
}

# Echo bold and green
function _TITLE_ECHO() {
    echo -e "\033[1;32m$1\033[0m"
}

# ---------------------------------------

_TITLE_ECHO "Update and upgrade"
sudo apt update && sudo apt upgrade -y

# ---------------------------------------

_TITLE_ECHO "Nala"
sudo apt install nala
sudo nala fetch

# ---------------------------------------

# Check if a file named `.bash_aliases` exists in the current directory
if [ -f .bash_aliases ]; then
    # Copy the file to the home directory
    cp .bash_aliases ~/.bash_aliases
    _TITLE_ECHO "Copied .bash_aliases to the home directory"
fi

# ---------------------------------------

# Check if a directory with the name `.macros` exists
if [ -d .macros ]; then
    # Copy the directory to the home directory
    cp -r .macros ~/.macros
    _TITLE_ECHO "Copied .macros to the home directory"
fi

# ---------------------------------------

_TITLE_ECHO "Add repositories"
sudo add-apt-repository ppa:zhangsongcui3371/fastfetch
sudo add-apt-repository multiverse # Required by: Steam

sudo nala update && sudo nala upgrade -y 

# ---------------------------------------

_TITLE_ECHO "Necessary packages"
upd_ni \
    gnome-shell-extension-manager \
    ca-certificates \
    openssh-server \
    gnome-tweaks \
    shellcheck \
    fastfetch \
    ifconfig\
    flatpak \
    xdotool \
    btop \
    curl \
    nano \
    wget \
    git

_TITLE_ECHO "Python 3"
upd_ni  \
    python3 \
    python3-pip \
    python3-venv \
    python3-dev

# ---------------------------------------

_TITLE_ECHO "Setting background"
sudo wget -O /usr/share/backgrounds/black.png https://htmlcolorcodes.com/assets/images/colors/black-color-solid-background-1920x1080.png
gsettings set org.gnome.desktop.background picture-uri file:////usr/share/backgrounds/black.png
gsettings set org.gnome.desktop.background picture-uri-dark file:////usr/share/backgrounds/black.png

# ---------------------------------------

# echo "Install custom macros and .bash_aliases"
# sudo curl -fsSL https://raw.githubusercontent.com/RasseTheBoy/Ubuntu-quickstart/main

# ---------------------------------------

_TITLE_ECHO "Brave (beta)"
sudo curl -fsSLo /usr/share/keyrings/brave-browser-beta-archive-keyring.gpg https://brave-browser-apt-beta.s3.brave.com/brave-browser-beta-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-beta-archive-keyring.gpg] https://brave-browser-apt-beta.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-beta.list
upd_ni brave-browser-beta

# ---------------------------------------

_TITLE_ECHO "AppImages to Downloads"
wget -O ~/Downloads/beeper.AppImage https://download.beeper.com/linux/appImage/x64
wget -O ~/Downloads/bitwarden.AppImage "https://vault.bitwarden.com/download/?app=desktop&platform=linux"

# ---------------------------------------

_TITLE_ECHO "Spotify"
curl -sS https://download.spotify.com/debian/pubkey_6224F9941A8AA6D1.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
upd_ni spotify-client

# ---------------------------------------

_TITLE_ECHO "Lutris"
curl -LO "$(curl -s -L https://api.github.com/repos/lutris/lutris/releases/latest | jq -r '.assets[] | select(.name | endswith(".deb")) .browser_download_url')"
sudo nala install -y ./lutris*.deb
rm ./lutris*.deb

# ---------------------------------------

_TITLE_ECHO "VS Code"
wget -O vscode.deb https://update.code.visualstudio.com/latest/linux-deb-x64/stable
sudo nala install -y ./vscode.deb
rm ./vscode.deb

_TITLE_ECHO "VS Code extensions"
for extension in \
    ms-vscode-remote.remote-containers\
    DavidAnson.vscode-markdownlint \
    ms-azuretools.vscode-docker \
    ms-vscode-remote.remote-ssh \
    yzhang.markdown-all-in-one \
    bmalehorn.shell-syntax \
    Gruntfuggly.todo-tree \
    timonwong.shellcheck \
    ms-python.python \
    GitHub.copilot \
    Nur.just-black \
    ZainChen.json
do code --install-extension $extension; done

# ---------------------------------------

_TITLE_ECHO "Snap packages"

# Snap Install
si () {
    for pacakge in "$@"; do
        sudo snap install "$pacakge"
    done
}

sudo snap install blender --classic
si mailspring

# ---------------------------------------

_TITLE_ECHO "Flathub"
upd_ni gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo # Flathub
flatpak install flathub org.gimp.GIMP # GIMP
flatpak install flathub com.github.tchx84.Flatseal

# ---------------------------------------

_TITLE_ECHO "DisplayLink Driver"
wget -O displaylink.deb https://www.synaptics.com/sites/default/files/Ubuntu/pool/stable/main/all/synaptics-repository-keyring.deb
sudo nala install -y ./displaylink.deb
upd_ni displaylink-driver
rm ./displaylink.deb

# ---------------------------------------

_TITLE_ECHO "Docker"
# Add Docker's official GPG key:
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
# shellcheck disable=SC1091
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

#Install Docker:
upd_ni \
    docker-ce  \
    docker-ce-cli  \
    containerd.io  \
    docker-buildx-plugin  \
    docker-compose-plugin

# Add your user to the docker group:
sudo groupadd docker
sudo usermod -aG docker "$USER"
newgrp docker

# ---------------------------------------

sudo nala autoremove

# ---------------------------------------

_TITLE_ECHO "Steam"
sudo dpkg --add-architecture i386
upd_ni steam-installer
steam

# ---------------------------------------

_TITLE_ECHO "For everything to work properly, you need to restart your computer!"
