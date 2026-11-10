#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# for changing Hyprland Layouts (Master or Dwindle) on the fly

notif="$HOME/.config/swaync/images/ja.png"
source "$HOME/.config/hypr/scripts/HyprCompat.sh"

LAYOUT=$(hyprctl -j getoption general:layout | jq '.str' | sed 's/"//g')

case $LAYOUT in
"master")
	hypr_set general:layout dwindle
	if hypr_is_lua; then
		hyprctl eval 'hl.unbind("SUPER + J"); hl.unbind("SUPER + K")
			hl.bind("SUPER + J", hl.dsp.window.cycle_next({ next = true }))
			hl.bind("SUPER + K", hl.dsp.window.cycle_next({ next = false }))
			hl.bind("SUPER + O", hl.dsp.layout("togglesplit"))'
	else
		hyprctl keyword unbind SUPER,J
		hyprctl keyword unbind SUPER,K
		hyprctl keyword bind SUPER,J,cyclenext
		hyprctl keyword bind SUPER,K,cyclenext,prev
		hyprctl keyword bind SUPER,O,togglesplit
	fi
  notify-send -e -u low -i "$notif" " Dwindle Layout"
	;;
"dwindle")
	hypr_set general:layout master
	if hypr_is_lua; then
		hyprctl eval 'hl.unbind("SUPER + J"); hl.unbind("SUPER + K"); hl.unbind("SUPER + O")
			hl.bind("SUPER + J", hl.dsp.layout("cyclenext"))
			hl.bind("SUPER + K", hl.dsp.layout("cycleprev"))'
	else
		hyprctl keyword unbind SUPER,J
		hyprctl keyword unbind SUPER,K
		hyprctl keyword unbind SUPER,O
		hyprctl keyword bind SUPER,J,layoutmsg,cyclenext
		hyprctl keyword bind SUPER,K,layoutmsg,cycleprev
	fi
  notify-send -e -u low -i "$notif" " Master Layout"
	;;
*) ;;

esac
