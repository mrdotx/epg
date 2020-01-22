#!/bin/sh

# path:       ~/projects/iptv/epg.sh
# user:       klassiker [mrdotx]
# github:     https://github.com/mrdotx/iptv
# date:       2020-01-22T12:09:29+0100

source_file="/home/alarm/wg++/guide.xml"
destination_file="/srv/http/iptv/epg.xml"

# execute webgrab++
wg++

# copy to webserver
rm $destination_file
cp $source_file $destination_file
chmod 755 $destination_file

# copy to hermes
rsync -acqP $destination_file alarm@hermes:/srv/http/iptv/epg.xml
