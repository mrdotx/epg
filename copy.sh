#!/bin/sh

# path:       /home/klassiker/.local/share/repos/epg/copy.sh
# author:     klassiker [mrdotx]
# github:     https://github.com/mrdotx/epg
# date:       2020-06-02T10:53:43+0200

epg=$HOME/.local/share/repos/epg

# copy to webserver
printf ":: copy to hermes...\n"
rsync --info=progress2 -ac \
    --exclude="copy.sh" \
    --exclude="LICENSE.md" \
    --exclude="README.md" \
    --exclude="epg.service" \
    --exclude="epg.timer" \
    "$epg/" alarm@hermes:/srv/http/epg/

printf ":: copy to prometheus...\n"
rsync --info=progress2 -ac \
    --exclude="copy.sh" \
    --exclude="LICENSE.md" \
    --exclude="README.md" \
    --exclude="epg.service" \
    --exclude="epg.timer" \
    "$epg/" alarm@prometheus:/srv/http/epg/

printf ":: copy completed!\n"

notify-send "epg" "copy finished" --icon=messagebox_info
