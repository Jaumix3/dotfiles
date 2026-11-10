pragma Singleton
pragma ComponentBehavior: Bound

import "root:/modules/common"
import "root:/modules/common/functions/fuzzysort.js" as Fuzzy
import QtQuick
import Quickshell
import Quickshell.Io

/**
 * Emoji list for the emoji search prefix. Reuses the list shipped in
 * ~/.config/hypr/scripts/RofiEmoji.sh (lines after "# # DATA # #").
 */
Singleton {
    id: root
    property string dataPath: `${Directories.hyprConfig}/scripts/RofiEmoji.sh`
    property list<string> list: []
    readonly property var preparedEntries: list.map(entry => ({
        name: Fuzzy.prepare(entry),
        entry: entry
    }))

    function fuzzyQuery(search: string): var {
        return Fuzzy.go(search, preparedEntries, {
            all: true,
            key: "name"
        }).map(r => r.obj.entry);
    }

    FileView {
        path: root.dataPath
        onLoaded: {
            const content = text();
            // The marker on a line of its own (the script also mentions it in a sed command)
            const marker = content.search(/^# # DATA # #$/m);
            if (marker < 0) return;
            root.list = content.slice(marker).split("\n").slice(1)
                .map(line => line.trim())
                .filter(line => line.length > 0);
        }
    }
}
