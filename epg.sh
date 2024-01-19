#!/bin/sh

# path:   /home/klassiker/.local/share/repos/epg/epg.sh
# author: klassiker [mrdotx]
# github: https://github.com/mrdotx/epg
# date:   2024-01-19T10:43:56+0100

# helper
move_file() {
    rsync -acqPh \
        --chmod=F644 \
        --remove-source-files \
        "$1" "$2" \
        && printf "%s moved to %s\n" "$1" "$2"
}

sync_file() {
    rsync -acqPh \
        --chmod=F644 \
        "$1" "$2" \
        && printf "%s synced to %s\n" "$1" "$2"
}

# execute webgrab++
wg++

# transfer to webserver
move_file \
    "$HOME/wg++/epg.xml" \
    "/srv/http/download/epg/epg.xml"
sync_file \
    "$HOME/.local/share/repos/epg/playlists/xitylight.m3u" \
    "/srv/http/download/epg/channels.m3u"
