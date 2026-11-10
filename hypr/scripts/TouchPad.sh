#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# For disabling touchpad.
# Edit the Touchpad_Device on ~/.config/hypr/UserConfigs/Laptops.conf (and Laptops.lua) according to your system
# use hyprctl devices to get your system touchpad device name
# source https://github.com/hyprwm/Hyprland/discussions/4283?sort=new#discussioncomment-8648109

notif="$HOME/.config/swaync/images/ja.png"
source "$HOME/.config/hypr/scripts/HyprCompat.sh"

export STATUS_FILE="$XDG_RUNTIME_DIR/touchpad.status"

# Lua Hyprland has no $TOUCHPAD_ENABLED variable: toggle the device directly.
# The device name is read from Touchpad_Device in UserConfigs/Laptops.lua
set_touchpad() {
    if hypr_is_lua; then
        local device
        device=$(sed -nE 's/^local Touchpad_Device = "([^"]+)".*/\1/p' "$HOME/.config/hypr/UserConfigs/Laptops.lua")
        hyprctl eval "hl.device({ name = $(hypr_lua_str "$device"), enabled = $1 })"
    else
        hyprctl keyword '$TOUCHPAD_ENABLED' "$1" -r
    fi
}

enable_touchpad() {
    printf "true" >"$STATUS_FILE"
    notify-send -u low -i $notif  " Enabling" " touchpad"
    set_touchpad true
}

disable_touchpad() {
    printf "false" >"$STATUS_FILE"
    notify-send -u low -i $notif " Disabling" " touchpad"
    set_touchpad false
}

if ! [ -f "$STATUS_FILE" ]; then
  enable_touchpad
else
  if [ $(cat "$STATUS_FILE") = "true" ]; then
    disable_touchpad
  elif [ $(cat "$STATUS_FILE") = "false" ]; then
    enable_touchpad
  fi
fi
