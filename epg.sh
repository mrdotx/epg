#!/bin/sh

# path:   /home/klassiker/.local/share/repos/epg/epg.sh
# author: klassiker [mrdotx]
# github: https://github.com/mrdotx/epg
# date:   2025-01-09T07:20:07+0100

# config
logo_file="$HOME/.local/share/repos/epg/logos.csv"

# helper
sync_file() {
    rsync_options="-acqPh --chmod=F644"
    result=" synced"

    [ "$1" = "--move" ] \
        && shift \
        && rsync_options="$rsync_options --remove-source-files" \
        && result="  moved"

    eval "rsync $rsync_options $1 $2" \
        && printf "%s: %s -> %s\n" "$result" "$1" "$2"
}

update_logos() {
    while IFS= read -r line; do
        logo=$(printf "%s" "$line" | cut -d';' -f1 | sed 's#\/#\\/#')
        url=$(printf "%s" "$line" | cut -d';' -f2)

        sed -i "/<display-name.*>$logo<\/display-name>/{n;s#.*#    <icon src=\"$url\" \/>#}" "$1"
    done < "$logo_file" \
    && printf "updated: %s -> urls for channel logos\n" "$1"
}

# execute webgrab++
wg++ >/dev/null 2>&1

# post process
update_logos \
    "$HOME/wg++/epg.xml"

# move epg file to web server
[ "$(stat -c %s "$HOME/wg++/epg.xml")" -gt 16384 ] \
    && sync_file --move \
        "$HOME/wg++/epg.xml" \
        "/srv/http/epg/epg.xml"

# sync channels file with web server
sync_file \
    "$HOME/.local/share/repos/epg/playlists/xitylight.m3u" \
    "/srv/http/epg/channels.m3u"
