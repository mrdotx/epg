#!/bin/sh

# path:       ~/projects/iptv/copy.sh
# author:     klassiker [mrdotx]
# github:     https://github.com/mrdotx/iptv
# date:       2020-02-23T20:54:32+0100

iptv=$HOME/projects/iptv

# copy to webserver
printf ":: copy to hermes...\n"
rsync --info=progress2 -ac \
    --exclude="copy.sh" \
    --exclude="LICENSE.md" \
    --exclude="README.md" \
    "$iptv/" alarm@hermes:/srv/http/iptv/

printf ":: copy to prometheus...\n"
rsync --info=progress2 -ac \
    --exclude="copy.sh" \
    --exclude="LICENSE.md" \
    --exclude="README.md" \
    "$iptv/" alarm@prometheus:/srv/http/iptv/

printf ":: copy completed!\n"

notify-send "IpTV" "Copy complete!" --icon=messagebox_info
