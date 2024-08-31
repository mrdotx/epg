#!/bin/sh

# path:   /home/klassiker/.local/share/repos/epg/epg.sh
# author: klassiker [mrdotx]
# github: https://github.com/mrdotx/epg
# date:   2024-08-31T08:14:01+0200

# helper
copy_file() {
    rsync_options="-acqPh --chmod=F644"
    result="synced"

    [ "$1" = "--move" ] \
        && shift \
        && rsync_options="$rsync_options --remove-source-files" \
        && result="moved"

    eval "rsync $rsync_options $1 $2" \
        && printf "%s: %s -> %s\n" "$result" "$1" "$2"
}

# execute webgrab++
wg++

# transfer to webserver
copy_file \
    "$HOME/.local/share/repos/epg/playlists/xitylight.m3u" \
    "/srv/http/epg/channels.m3u"
copy_file --move \
    "$HOME/wg++/epg.xml" \
    "/srv/http/epg/epg.xml"

# epg web
copy_file \
    "/srv/http/epg/epg.xml" \
    "/srv/http/epg/epg_web.xml"
