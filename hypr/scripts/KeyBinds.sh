#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# searchable enabled keybinds using rofi

# kill yad to not interfere with this binds
pkill yad || true

# check if rofi is already running
if pidof rofi > /dev/null; then
  pkill rofi
fi

# define the config files
keybinds_conf="$HOME/.config/hypr/configs/Keybinds.conf"
user_keybinds_conf="$HOME/.config/hypr/UserConfigs/UserKeybinds.conf"
laptop_conf="$HOME/.config/hypr/UserConfigs/Laptops.conf"
rofi_theme="$HOME/.config/rofi/config-keybinds.rasi"
msg='☣️ NOTE ☣️: Clicking with Mouse or Pressing ENTER will have NO function'

# Hyprland 0.55+ uses the Lua config: list the binds from the .lua files
lua_files=("${keybinds_conf%.conf}.lua" "${user_keybinds_conf%.conf}.lua" "${laptop_conf%.conf}.lua")
if [[ -f "$HOME/.config/hypr/hyprland.lua" && -f "${lua_files[0]}" ]]; then
    display_keybinds=$(cat "${lua_files[@]}" 2>/dev/null | grep -E '^\s*bind\(' \
        | sed -E 's/^\s*bind\(//; s/mainMod \.\. " ?\+? ?/"SUPER + /; s/^"([^"]*)",/\1,/')
else
    # combine the contents of the keybinds files and filter for keybinds
    keybinds=$(cat "$keybinds_conf" "$user_keybinds_conf" | grep -E '^bind')

    # check if laptop.conf exists and add its keybinds if present
    if [[ -f "$laptop_conf" ]]; then
        laptop_binds=$(grep -E '^bind' "$laptop_conf")
        keybinds+=$'\n'"$laptop_binds"
    fi

    # replace $mainmod with super in the displayed keybinds for rofi
    display_keybinds=$(echo "$keybinds" | sed 's/\$mainMod/SUPER/g')
fi

# check for any keybinds to display
if [[ -z "$display_keybinds" ]]; then
    echo "no keybinds found."
    exit 1
fi

# use rofi to display the keybinds with the modified content
echo "$display_keybinds" | rofi -dmenu -i -config "$rofi_theme" -mesg "$msg"