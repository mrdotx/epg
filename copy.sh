#!/bin/sh

# path:       /home/klassiker/.local/share/repos/epg/copy.sh
# author:     klassiker [mrdotx]
# github:     https://github.com/mrdotx/epg
# date:       2020-12-25T16:40:11+0100

epg=$HOME/.local/share/repos/epg

# copy to webserver
printf ":: copy to hermes...\n"
rsync --info=progress2 -ac \
    --exclude=".git" \
    --exclude=".gitignore" \
    --exclude="copy.sh" \
    --exclude="LICENSE.md" \
    --exclude="README.md" \
    --exclude="epg.service" \
    --exclude="epg.timer" \
    "$epg/" alarm@hermes:/srv/http/epg/
printf "\n"

printf ":: copy to prometheus...\n"
rsync --info=progress2 -ac \
    --exclude=".git" \
    --exclude=".gitignore" \
    --exclude="copy.sh" \
    --exclude="LICENSE.md" \
    --exclude="README.md" \
    --exclude="epg.service" \
    --exclude="epg.timer" \
    "$epg/" alarm@prometheus:/srv/http/epg/
printf "\n"

notify-send \
    "epg" \
    "copy finished"
