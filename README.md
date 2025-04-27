# epg

config files and scripts for webgrab++ in combination with a fritzbox

| folder       | comment                    |
| :----------- | :------------------------- |
| playlists    | fritzbox example m3u files |
| siteini.user | webgrab++ siteini files    |
| systemd      | systemd services and timer |

| file             | comment                                                           |
| :--------------- | :---------------------------------------------------------------- |
| epg.sh           | convert dates to local time zone and sync/move files to webserver |
| logos.csv        | expample logos file to replace logos with epg.sh                  |
| logos.sh         | extract tvg-logo and tvg-id from a m3u file                       |
| m3u_converter.sh | converts a m3u file to a csv file and vice versa                  |

package files:

- [pkgbuilds/wg++-legacy](https://github.com/mrdotx/pkgbuilds/tree/master/wg%2B%2B-legacy)
