pragma Singleton
pragma ComponentBehavior: Bound

import "root:/modules/common/functions/fuzzysort.js" as Fuzzy
import QtQuick
import Quickshell
import Quickshell.Io

/**
 * Clipboard history from cliphist, for the clipboard search prefix.
 */
Singleton {
    id: root
    property list<string> entries: []
    readonly property var preparedEntries: entries.map(entry => ({
        name: Fuzzy.prepare(entry.replace(/^\s*\S+\s+/, "")),
        entry: entry
    }))

    function refresh() {
        readProc.buffer = []
        readProc.running = true
    }

    function fuzzyQuery(search: string): var {
        if (search.trim() === "") return entries;
        return Fuzzy.go(search, preparedEntries, {
            all: true,
            key: "name"
        }).map(r => r.obj.entry);
    }

    Process {
        id: readProc
        property list<string> buffer: []
        command: ["cliphist", "list"]
        stdout: SplitParser {
            onRead: line => readProc.buffer.push(line)
        }
        onExited: (exitCode, exitStatus) => {
            if (exitCode === 0) root.entries = readProc.buffer
        }
    }
}
