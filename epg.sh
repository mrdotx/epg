#!/bin/sh

# path:   /home/klassiker/.local/share/repos/epg/epg.sh
# author: klassiker [mrdotx]
# github: https://github.com/mrdotx/epg
# date:   2023-02-24T10:16:32+0100

source_epg="$HOME/wg++/epg.xml"
destination_epg="/srv/http/download/epg/epg.xml"
source_m3u="$HOME/.local/share/repos/epg/xitylight.m3u"
destination_m3u="/srv/http/download/epg/channels.m3u"

# helper
copy_local() {
    rsync -acqPh \
        --chmod=F755 \
        --remove-source-files \
        "$source_epg" "$destination_epg" \
        && printf "%s copied to %s\n" "$source_epg" "$destination_epg"

    rsync -acqPh \
        --chmod=F755 \
        "$source_m3u" "$destination_m3u" \
        && printf "%s synced to %s\n" "$source_m3u" "$destination_m3u"
}

copy_remote() {
    rsync -acqPh \
        --chmod=F755 \
        --remove-source-files \
        "$source_epg" "$1":$destination_epg \
        && printf "%s copied to %s:%s\n" "$source_epg" "$1" "$destination_epg"

    rsync -acqPh \
        --chmod=F755 \
        "$source_m3u" "$1":$destination_m3u \
        && printf "%s synced to %s\n" "$source_m3u" "$destination_m3u"
}

# execute webgrab++
wg++

# copy to webserver
copy_local
#copy_remote "hostname"
