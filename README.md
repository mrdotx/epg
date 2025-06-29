# epg

config files and scripts for webgrab++ in combination with a fritzbox

| folder       | comment                        |
| :----------- | :----------------------------- |
| playlists    | fritzbox example m3u/csv files |
| siteini.user | webgrab++ siteini files        |
| systemd      | systemd services and timer     |

| file             | comment                                                           |
| :--------------- | :---------------------------------------------------------------- |
| epg.sh           | convert dates to local time zone and sync/move files to webserver |
| m3u_converter.sh | converts a m3u file to a csv file and vice versa (extract logos)  |

package files:

- [pkgbuilds/wg++-legacy](https://github.com/mrdotx/pkgbuilds/tree/master/wg%2B%2B-legacy)
