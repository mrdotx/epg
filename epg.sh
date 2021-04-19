#!/bin/sh

# path:   /home/klassiker/.local/share/repos/epg/epg.sh
# author: klassiker [mrdotx]
# github: https://github.com/mrdotx/epg
# date:   2021-04-19T15:04:30+0200

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
    rsync -acqPh $destination_file alarm@"$1":$destination_file
}

case $host_name in
    hermes)
        copy_to "prometheus"
        ;;
    prometheus)
        copy_to "hermes"
        ;;
esac
