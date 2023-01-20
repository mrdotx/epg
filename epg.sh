#!/bin/sh

# path:   /home/klassiker/.local/share/repos/epg/epg.sh
# author: klassiker [mrdotx]
# github: https://github.com/mrdotx/epg
# date:   2023-01-20T12:27:00+0100

source_file="$HOME/wg++/epg.xml"
destination_file="/srv/http/download/epg/epg.xml"

# execute webgrab++
wg++

# helper
copy_to() {
    rsync -acqPh \
        --chmod=F755 \
        --remove-source-files \
        "$source_file" "$1":$destination_file \
        && printf "%s copied to %s:%s\n" "$source_file" "$1" "$destination_file"
}

# copy to webserver
copy_to "m625q"
