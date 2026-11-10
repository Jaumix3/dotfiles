#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Script for changing blurs on the fly

notif="$HOME/.config/swaync/images"
source "$HOME/.config/hypr/scripts/HyprCompat.sh"

STATE=$(hyprctl -j getoption decoration:blur:passes | jq ".int")

if [ "${STATE}" == "2" ]; then
	hypr_set decoration:blur:size 2
	hypr_set decoration:blur:passes 1
 	notify-send -e -u low -i "$notif/note.png" " Less Blur"
else
	hypr_set decoration:blur:size 5
	hypr_set decoration:blur:passes 2
  	notify-send -e -u low -i "$notif/ja.png" " Normal Blur"
fi
