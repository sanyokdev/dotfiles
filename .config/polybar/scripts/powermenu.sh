#!/bin/bash

choice=$(printf " Log Out\n Power Off\n Restart" | rofi -dmenu -i -p "Power option:")
case "$choice" in
    " Log Out") bspc quit ;;
    " Power Off") systemctl poweroff ;;
    " Restart") systemctl reboot ;;
    *) exit 1 ;;
esac
