#!/bin/bash

# Create a yad form with buttons and sliders
yad_output=$(yad --form --width=300 --title="Custom Menu" \
    --field="WiFi:BTN" '!~/.config/waybar/scripts/custom_menu.sh action wifi' \
    --field="Bluetooth:BTN" '!~/.config/waybar/scripts/custom_menu.sh action bluetooth' \
    --field="Backlight:HSCALE" '10!50!100!1' \
    --field="Volume:HSCALE" '0!50!100!1' \
    --buttons-layout=center)

# Read the values from the yad output and update settings
IFS="|" read -r wifi_action bluetooth_action backlight_value volume_value <<< "$yad_output"

~/.config/waybar/scripts/custom_menu.sh action backlight $backlight_value
~/.config/waybar/scripts/custom_menu.sh action volume $volume_value
