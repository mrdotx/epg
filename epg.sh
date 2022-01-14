#!/bin/sh

# path:   /home/klassiker/.local/share/repos/epg/epg.sh
# author: klassiker [mrdotx]
# github: https://github.com/mrdotx/epg
# date:   2022-01-14T14:03:09+0100

source_file="$HOME/wg++/guide.xml"
destination_file="/srv/http/epg/epg.xml"

# execute webgrab++
wg++

# move to webserver
mv -f "$source_file" $destination_file
chmod 755 $destination_file

# copy to 2nd webserver
host_name="$(cat /proc/sys/kernel/hostname)"

copy_to() {
    rsync -acqPh $destination_file "$1":$destination_file
}

case $host_name in
    pi)
        copy_to "pi2"
        ;;
    pi2)
        copy_to "pi"
        ;;
esac
