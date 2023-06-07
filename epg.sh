#!/bin/sh

# path:   /home/klassiker/.local/share/repos/epg/epg.sh
# author: klassiker [mrdotx]
# github: https://github.com/mrdotx/epg
# date:   2023-06-07T07:41:59+0200

# helper
copy_file() {
    rsync -acqPh \
        --chmod=F644 \
        --remove-source-files \
        "$1" "$2" \
        && printf "%s copied to %s\n" "$1" "$2"
}

sync_file() {
    rsync -acqPh \
        --chmod=F644 \
        "$1" "$2" \
        && printf "%s synced with %s\n" "$1" "$2"
}

# execute webgrab++
wg++

# transfer to webserver
copy_file \
    "$HOME/wg++/epg.xml" \
    "/srv/http/download/epg/epg.xml"
sync_file \
    "$HOME/.local/share/repos/epg/xitylight.m3u" \
    "/srv/http/download/epg/channels.m3u"
