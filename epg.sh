#!/bin/sh

# path:   /home/klassiker/.local/share/repos/epg/epg.sh
# author: klassiker [mrdotx]
# github: https://github.com/mrdotx/epg
# date:   2023-02-25T08:54:10+0100

source_epg="$HOME/wg++/epg.xml"
destination_epg="/srv/http/download/epg/epg.xml"
source_m3u="$HOME/.local/share/repos/epg/xitylight.m3u"
destination_m3u="/srv/http/download/epg/channels.m3u"

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
copy_file "$source_epg" "$destination_epg"
sync_file "$source_m3u" "$destination_m3u"
