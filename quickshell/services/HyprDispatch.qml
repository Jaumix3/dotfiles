pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland

/**
 * Hyprland dispatchers that work with both config formats.
 * Hyprland 0.55+ runs a Lua config and only accepts Lua dispatchers (hl.dsp.*);
 * older versions only accept the legacy "dispatcher args" syntax.
 */
Singleton {
    id: root

    // Lua Hyprland is assumed until the check below says otherwise.
    property bool lua: true

    function luaString(text) {
        return `[==[${text}]==]`
    }

    function exec(command) {
        Hyprland.dispatch(lua ? `hl.dsp.exec_cmd(${luaString(command)})` : `exec ${command}`)
    }

    function global(name) {
        Hyprland.dispatch(lua ? `hl.dsp.global(${luaString(name)})` : `global ${name}`)
    }

    function workspace(id) {
        Hyprland.dispatch(lua ? `hl.dsp.focus({ workspace = ${luaString(id)} })` : `workspace ${id}`)
    }

    function moveToWorkspaceSilent(id, address) {
        Hyprland.dispatch(lua
            ? `hl.dsp.window.move({ workspace = ${luaString(id)}, follow = false, window = ${luaString("address:" + address)} })`
            : `movetoworkspacesilent ${id}, address:${address}`)
    }

    function focusWindow(address) {
        Hyprland.dispatch(lua ? `hl.dsp.focus({ window = ${luaString("address:" + address)} })` : `focuswindow address:${address}`)
    }

    function closeWindow(address) {
        Hyprland.dispatch(lua ? `hl.dsp.window.close({ window = ${luaString("address:" + address)} })` : `closewindow address:${address}`)
    }

    // `hyprctl eval` only exists on Lua Hyprland and answers "ok".
    Process {
        running: true
        command: ["hyprctl", "eval", "return 1"]
        stdout: StdioCollector {
            onStreamFinished: root.lua = text.trim() === "ok"
        }
    }
}
