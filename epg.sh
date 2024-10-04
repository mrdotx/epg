#!/bin/sh

# path:   /home/klassiker/.local/share/repos/epg/epg.sh
# author: klassiker [mrdotx]
# github: https://github.com/mrdotx/epg
# date:   2024-10-04T07:49:14+0200

# helper
copy_file() {
    rsync_options="-acqPh --chmod=F644"
    result=" synced"

    [ "$1" = "--move" ] \
        && shift \
        && rsync_options="$rsync_options --remove-source-files" \
        && result="  moved"

    eval "rsync $rsync_options $1 $2" \
        && printf "%s: %s -> %s\n" "$result" "$1" "$2"
}

convert_date() {
    date_string=$( \
        printf "%s\n" "$1" \
            | sed \
                -e 's/./&-/4' \
                -e 's/./&-/7' \
                -e 's/./&T/10' \
                -e 's/./&:/13' \
                -e 's/./&:/16' \
    )

    date -d "$date_string" +'%Y%m%d%H%M%S %z'
}

update_dates() {
    y99="\(20[0-9][0-9]\)"
    m12="\([0-1][0-9]\)"
    d31="\([0-3][0-9]\)"
    t24="\([0-2][0-9]\)"
    t60="\([0-5][0-9]\)"
    z="\(+0000\)"
    filter="$y99$m12$d31$t24$t60$t60 $z"

    grep -o "$filter" "$1" \
        | sort -u \
        | while IFS= read -r old_date; do
            new_date=$(convert_date "$old_date")
            sed -i "s/$old_date/$new_date/g" "$1"
        done \
        && printf "updated: convert dates in %s\n to local time zone" "$1"
}

# execute webgrab++
wg++

# convert dates to local time zone
update_dates \
    "$HOME/wg++/epg.xml"

# transfer to web server
copy_file \
    "$HOME/.local/share/repos/epg/playlists/xitylight.m3u" \
    "/srv/http/epg/channels.m3u"
copy_file --move \
    "$HOME/wg++/epg.xml" \
    "/srv/http/epg/epg.xml"
