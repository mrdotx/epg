#!/bin/sh

# path:       /home/klassiker/.local/share/repos/epg/epg.sh
# author:     klassiker [mrdotx]
# github:     https://github.com/mrdotx/epg
# date:       2020-06-02T10:54:07+0200

source_file="/home/alarm/wg++/guide.xml"
destination_file="/srv/http/epg/epg.xml"

# execute webgrab++
wg++

# copy to webserver
rm $destination_file
cp $source_file $destination_file
chmod 755 $destination_file

# copy to hermes
rsync -acqP $destination_file alarm@hermes:/srv/http/epg/epg.xml
