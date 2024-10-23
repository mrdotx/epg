#!/bin/sh

# path:   /home/klassiker/.local/share/repos/epg/m3u_converter.sh
# author: klassiker [mrdotx]
# github: https://github.com/mrdotx/epg
# date:   2024-10-23T08:06:48+0200

ext="${1##*.}"

# helper
get_value() {
    tag="$1"
    shift

    printf "%s\n" "$*" \
        | awk -F "$tag=" '{print $2}' \
        | cut -d'"' -f2
}

# main
case $ext in
    *m3u|*m3u8)
        csv="${1%."$ext"}.csv"

        printf "tvg-name\tgroup-title\ttvg-logo\ttvg-id\turi\n" > "$csv"

        grep -v "#EXTM3U\|#EXTVLCOPT\|^[[:space:]]*$" "$1" \
            | while IFS= read -r line; do
                name=$(get_value 'tvg-name' "$line")
                group=$(get_value 'group-title' "$line")
                logo=$(get_value 'tvg-logo' "$line")
                id=$(get_value 'tvg-id' "$line")
                IFS= read -r uri
                printf "%s\t%s\t%s\t%s\t%s\n" \
                    "$name" \
                    "$group" \
                    "$logo" \
                    "$id" \
                    "$uri" >> "$csv"
            done

        printf "\"%s\" converted to \"%s\"\n" "$1" "$csv"
        ;;
    *csv)
        m3u="${1%."$ext"}.m3u"

        printf "#EXTM3U\n" > "$m3u"

        grep -v "tvg-name	group-title	tvg-logo	tvg-id	uri" "$1" \
            | awk -F "\t" '{print "#EXTINF:-1 tvg-name=\"" $1 \
                        "\" group-title=\"" $2 \
                        "\" tvg-logo=\"" $3 \
                        "\" tvg-id=\"" $4 \
                        "\"," $1 "\n" $5}' >> "$m3u"

        printf "\"%s\" converted to \"%s\"\n" "$1" "$m3u"
        ;;
esac
