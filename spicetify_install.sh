#!/bin/bash

# Echo bold and green
function _TITLE_ECHO() {
    echo -e "\033[1;32m$1\033[0m"
}

_TITLE_ECHO "Instlling Spicetfiy"
# shellcheck source=/dev/null
source ~/.bashrc
sudo chmod a+wr /usr/share/spotify
sudo chmod a+wr /usr/share/spotify/Apps -R
curl -fsSL https://raw.githubusercontent.com/spicetify/cli/main/install.sh | sh
spicetify backup apply
rm ./install.log