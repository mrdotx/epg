#!/bin/sh

# path:       /home/klassiker/.local/share/repos/epg/epg.sh
# author:     klassiker [mrdotx]
# github:     https://github.com/mrdotx/epg
# date:       2020-10-11T11:02:51+0200

source_file="/home/alarm/wg++/guide.xml"
destination_file="/srv/http/epg/epg.xml"

# execute webgrab++
wg++

# move to webserver
mv -f $source_file $destination_file
chmod 755 $destination_file

# copy to 2nd webserver
rsync -acqP $destination_file alarm@hermes:$destination_file
