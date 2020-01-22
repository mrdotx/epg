#!/bin/sh

# path:       ~/projects/iptv/copy.sh
# user:       klassiker [mrdotx]
# github:     https://github.com/mrdotx/iptv
# date:       2020-01-22T12:13:13+0100

# color variables
#black=$(tput setaf 0)
#red=$(tput setaf 1)
#green=$(tput setaf 2)
#yellow=$(tput setaf 3)
#blue=$(tput setaf 4)
magenta=$(tput setaf 5)
#cyan=$(tput setaf 6)
#white=$(tput setaf 7)
reset=$(tput sgr0)

iptv=$HOME/projects/iptv

# copy to webserver
echo "[${magenta}info${reset}] Copy to hermes..."
rsync --info=progress2 -ac \
    --exclude="copy.sh" \
    --exclude="LICENSE.md" \
    --exclude="README.md" \
    "$iptv/" alarm@hermes:/srv/http/iptv/

echo "[${magenta}info${reset}] Copy to prometheus..."
rsync --info=progress2 -ac \
    --exclude="copy.sh" \
    --exclude="LICENSE.md" \
    --exclude="README.md" \
    "$iptv/" alarm@prometheus:/srv/http/iptv/

echo "[${magenta}info${reset}] Copy completed!"

notify-send "IpTV" "Copy complete!" --icon=messagebox_info
