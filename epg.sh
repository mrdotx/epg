#!/bin/sh

# path:   /home/klassiker/.local/share/repos/epg/epg.sh
# author: klassiker [mrdotx]
# github: https://github.com/mrdotx/epg
# date:   2022-02-13T20:19:33+0100

source_file="$HOME/wg++/guide.xml"
destination_file="/srv/http/epg/epg.xml"

# execute webgrab++
wg++

# move to webserver
mv -f "$source_file" $destination_file
chmod 755 $destination_file

# copy to 2nd webserver
copy_to() {
    rsync -acqPh $destination_file "$1":$destination_file
}

case "$(hostname)" in
    pi2)
        copy_to "pi"
        ;;
    pi)
        copy_to "pi2"
        ;;
esac
