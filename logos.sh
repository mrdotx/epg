#!/bin/sh

# path:   /home/klassiker/.local/share/repos/epg/logos.sh
# author: klassiker [mrdotx]
# github: https://github.com/mrdotx/epg
# date:   2024-11-07T06:33:32+0100

# speed up script and avoid language problems by using standard c
LC_ALL=C
LANG=C

# config
channel_list="$HOME/.local/share/repos/epg/playlists/xitylight.m3u"

awk '
        /tvg-logo=/{
            match($0,/tvg-logo="[^"]*/);
            num=split(substr($0,RSTART,RLENGTH),a,"=\"");
            match($0,/tvg-id="[^"]*/);
            num1=split(substr($0,RSTART,RLENGTH),b,"=\"");
            print b[num],";",a[num1]
        }' "$channel_list" \
    | sed "s/ ; /;/g" \
    | sort -u
