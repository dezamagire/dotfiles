#!/bin/bash

# This function generates the JSON output for Waybar
generate_output() {
    wifi_status=$(nmcli radio wifi)
    bluetooth_status=$(bluetoothctl show | grep "Powered" | awk '{print $2}')
    battery_status=$(acpi -b | grep -P -o '[0-9]+(?=%)')
    volume_status=$(pamixer --get-volume-human)

    cat <<EOF
{
    "text": "Menu",
    "tooltip": "<b>WiFi:</b> $wifi_status\n<b>Bluetooth:</b> $bluetooth_status\n<b>Battery:</b> $battery_status%\n<b>Volume:</b> $volume_status",
    "class": "custom-menu"
}
EOF
}

# This function handles the menu interactions
handle_menu_action() {
    action=$1
    case $action in
        wifi)
            nmcli radio wifi $(nmcli radio wifi | grep -q enabled && echo off || echo on)
            ;;
        bluetooth)
            bluetoothctl power $(bluetoothctl show | grep -q "Powered: yes" && echo off || echo on)
            ;;
        backlight)
            brightnessctl set $2%
            ;;
        volume)
            pactl set-sink-volume @DEFAULT_SINK@ $2%
            ;;
    esac
}

# Main script logic
if [[ "$1" == "action" ]]; then
    handle_menu_action $2 $3
else
    generate_output
fi
