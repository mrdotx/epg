#!/bin/sh

# path:   /home/klassiker/.local/share/repos/epg/m3u_converter.sh
# author: klassiker [mrdotx]
# github: https://github.com/mrdotx/epg
# date:   2025-06-29T05:23:39+0200

# speed up script and avoid language problems by using standard c
LC_ALL=C
LANG=C

# config
file_ext=${1##*.}
file_name=${1%."$file_ext"}

# helper
get_value() {
    tag="$1"
    shift

    printf "%s\n" "$*" \
        | awk -F "$tag=" '{print $2}' \
        | cut -d'"' -f2
}

m3u_to_csv_logos() {
    # extract tvg-logo and tvg-id from channel list
    awk '
            /tvg-logo=/{
                match($0,/tvg-logo="[^"]*/);
                num=split(substr($0,RSTART,RLENGTH),a,"=\"");
                match($0,/tvg-id="[^"]*/);
                num1=split(substr($0,RSTART,RLENGTH),b,"=\"");
                print b[num],";",a[num1]
            }' "$1" \
        | sed "s/ ; /;/g" \
        | sort -u > "$2"
}

m3u_to_csv() {
    printf "tvg-name\tgroup-title\ttvg-logo\ttvg-id\turi\n" > "$2"

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
                "$uri" >> "$2"
        done
}

csv_to_m3u() {
    printf "#EXTM3U\n" > "$2"

    grep -v "tvg-name	group-title	tvg-logo	tvg-id	uri" "$1" \
        | awk -F "\t" '{print "#EXTINF:-1 tvg-name=\"" $1 \
                    "\" group-title=\"" $2 \
                    "\" tvg-logo=\"" $3 \
                    "\" tvg-id=\"" $4 \
                    "\"," $1 "\n" $5}' >> "$2"
}

# main
case $file_ext in
    *m3u|*m3u8)
        output_file="$file_name.csv"
        printf "convert: %s -> %s\n" "${1##*/}" "${output_file##*/}"

        case "$2" in
            --logos)
                m3u_to_csv_logos "$1" "$output_file"
                ;;
            *)
                m3u_to_csv "$1" "$output_file"
                ;;
        esac
        ;;
    *csv)
        output_file="$file_name.m3u"
        printf "convert: %s -> %s\n" "${1##*/}" "${output_file##*/}"

        csv_to_m3u "$1" "$output_file"
        ;;
esac
