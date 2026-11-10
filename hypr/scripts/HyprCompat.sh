#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Helpers for scripts that drive Hyprland through hyprctl. Source it:
#   source "$HOME/.config/hypr/scripts/HyprCompat.sh"
#
# Hyprland 0.55+ uses a Lua config: `hyprctl keyword` is gone and `hyprctl dispatch`
# only takes Lua dispatchers (hl.dsp.*). Older versions only know the legacy syntax.
# These helpers take the legacy form and translate it when Hyprland runs Lua.

# True when Hyprland runs the Lua config (`hyprctl eval` only exists there).
hypr_is_lua() {
    if [[ -z "$HYPR_IS_LUA" ]]; then
        if [[ "$(hyprctl eval 'return 1' 2>/dev/null)" == "ok" ]]; then
            HYPR_IS_LUA=1
        else
            HYPR_IS_LUA=0
        fi
    fi
    [[ "$HYPR_IS_LUA" == 1 ]]
}

# Quote a string as a Lua long string literal.
hypr_lua_str() {
    printf '[==[%s]==]' "$1"
}

# Lua literal for a config value: numbers and booleans stay bare, the rest is quoted.
hypr_lua_value() {
    if [[ "$1" =~ ^-?[0-9]+(\.[0-9]+)?$ || "$1" == "true" || "$1" == "false" ]]; then
        printf '%s' "$1"
    else
        hypr_lua_str "$1"
    fi
}

# Set a config option at runtime, like `hyprctl keyword`.
#   hypr_set decoration:blur:passes 2
hypr_set() {
    local option="$1" value="$2"
    if ! hypr_is_lua; then
        hyprctl keyword "$option" "$value"
        return
    fi
    local IFS=':' parts lua="" close="" i
    read -ra parts <<<"$option"
    for ((i = 0; i < ${#parts[@]} - 1; i++)); do
        lua+="${parts[i]} = { "
        close+=" }"
    done
    lua+="${parts[-1]} = $(hypr_lua_value "$value")"
    hyprctl eval "hl.config({ ${lua}${close} })"
}

# Run a dispatcher given in the legacy syntax, e.g.
#   hypr_dispatch movetoworkspacesilent "3,address:0x1234"
# Only the dispatchers used by these scripts are translated to Lua.
hypr_dispatch() {
    local dispatcher="$1" args="$2"
    if ! hypr_is_lua; then
        hyprctl dispatch "$dispatcher" "$args"
        return
    fi

    local target="" lua
    # Split a trailing ",address:..." window selector off the arguments
    if [[ "$args" == *,address:* ]]; then
        target="address:${args##*,address:}"
        args="${args%,address:*}"
    elif [[ "$args" == address:* ]]; then
        target="$args"
        args=""
    fi
    local window=""
    [[ -n "$target" ]] && window=", window = $(hypr_lua_str "$target")"

    case "$dispatcher" in
    workspace)
        lua="hl.dsp.focus({ workspace = $(hypr_lua_str "$args") })" ;;
    movetoworkspace)
        lua="hl.dsp.window.move({ workspace = $(hypr_lua_str "$args")$window })" ;;
    movetoworkspacesilent)
        lua="hl.dsp.window.move({ workspace = $(hypr_lua_str "$args"), follow = false$window })" ;;
    focuswindow)
        lua="hl.dsp.focus({ window = $(hypr_lua_str "$target") })" ;;
    pin)
        lua="hl.dsp.window.pin({ ${window#, } })" ;;
    movewindowpixel | resizewindowpixel)
        # "exact X Y" (absolute) or "X Y" (relative)
        local exact="" x y kind=move
        [[ "$dispatcher" == resizewindowpixel ]] && kind=resize
        read -r x y <<<"$args"
        if [[ "$x" == "exact" ]]; then
            exact=1
            read -r _ x y <<<"$args"
        fi
        if [[ -n "$exact" ]]; then
            lua="hl.dsp.window.$kind({ x = $x, y = $y$window })"
        else
            lua="hl.dsp.window.$kind({ x = $x, y = $y, relative = true$window })"
        fi
        ;;
    exec)
        # Optional leading "[rule; rule] command" exec rules
        local cmd="$args" rules=""
        if [[ "$cmd" =~ ^\[([^]]*)\][[:space:]]*(.*)$ ]]; then
            cmd="${BASH_REMATCH[2]}"
            local rule key val IFS=';'
            for rule in ${BASH_REMATCH[1]}; do
                rule="${rule#"${rule%%[![:space:]]*}"}"
                key="${rule%% *}"
                val="${rule#"$key"}"
                val="${val# }"
                if [[ -z "$val" ]]; then
                    rules+="$key = true, "
                else
                    rules+="$key = $(hypr_lua_str "$val"), "
                fi
            done
        fi
        if [[ -n "$rules" ]]; then
            lua="hl.dsp.exec_cmd($(hypr_lua_str "$cmd"), { ${rules%, } })"
        else
            lua="hl.dsp.exec_cmd($(hypr_lua_str "$cmd"))"
        fi
        ;;
    *)
        echo "hypr_dispatch: no Lua translation for '$dispatcher'" >&2
        return 1
        ;;
    esac
    hyprctl dispatch "$lua"
}

# swww was renamed to awww upstream; use whichever is installed.
if command -v awww >/dev/null 2>&1; then
    SWWW=awww
else
    SWWW=swww
fi
