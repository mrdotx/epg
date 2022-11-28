#!/bin/sh

# path:   /home/klassiker/.local/share/repos/epg/epg.sh
# author: klassiker [mrdotx]
# github: https://github.com/mrdotx/epg
# date:   2022-11-28T18:19:35+0100

source_file="$HOME/wg++/epg.xml"
destination_file="/srv/http/download/epg/epg.xml"

# execute webgrab++
wg++

# helper
copy_to() {
    chmod 755 "$source_file"
    rsync -acqPh "$source_file" "$1":$destination_file \
        && printf "%s copied to %s\n" "$destination_file" "$1"
    rm -f "$source_file"
}

# copy to webserver
copy_to "pi"
