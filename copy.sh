#!/bin/sh

# path:       ~/repos/iptv/copy.sh
# author:     klassiker [mrdotx]
# github:     https://github.com/mrdotx/iptv
# date:       2020-02-28T08:10:51+0100

iptv=$HOME/repos/iptv

# copy to webserver
printf ":: copy to hermes...\n"
rsync --info=progress2 -ac \
    --exclude="copy.sh" \
    --exclude="LICENSE.md" \
    --exclude="README.md" \
    --exclude="epg.service" \
    --exclude="epg.timer" \
    "$iptv/" alarm@hermes:/srv/http/iptv/

printf ":: copy to prometheus...\n"
rsync --info=progress2 -ac \
    --exclude="copy.sh" \
    --exclude="LICENSE.md" \
    --exclude="README.md" \
    --exclude="epg.service" \
    --exclude="epg.timer" \
    "$iptv/" alarm@prometheus:/srv/http/iptv/

printf ":: copy completed!\n"

notify-send "IpTV" "Copy complete!" --icon=messagebox_info
