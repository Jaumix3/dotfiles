#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Game Mode. Turning off all animations

notif="$HOME/.config/swaync/images/ja.png"
SCRIPTSDIR="$HOME/.config/hypr/scripts"
source "$HOME/.config/hypr/scripts/HyprCompat.sh"


# "int: 1" on older Hyprland, "bool: true" on Lua Hyprland
HYPRGAMEMODE=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')
if [ "$HYPRGAMEMODE" = 1 ] || [ "$HYPRGAMEMODE" = true ] ; then
    hypr_set animations:enabled 0
    hypr_set decoration:shadow:enabled 0
    hypr_set decoration:blur:enabled 0
    hypr_set general:gaps_in 0
    hypr_set general:gaps_out 0
    hypr_set general:border_size 1
    hypr_set decoration:rounding 0

    if hypr_is_lua; then
        hyprctl eval 'hl.window_rule({ match = { class = ".*" }, opacity = "1 override 1 override 1 override" })'
    else
        hyprctl keyword "windowrule opacity 1 override 1 override 1 override, ^(.*)$"
    fi
    $SWWW kill 
    notify-send -e -u low -i "$notif" " Gamemode:" " enabled"
    exit
else
	$SWWW-daemon --format xrgb && $SWWW img "$HOME/.config/rofi/.current_wallpaper" &
	sleep 0.1
	${SCRIPTSDIR}/WallustSwww.sh
	sleep 0.5
	${SCRIPTSDIR}/Refresh.sh	 
    notify-send -e -u normal -i "$notif" " Gamemode:" " disabled"
    exit
fi
hyprctl reload
