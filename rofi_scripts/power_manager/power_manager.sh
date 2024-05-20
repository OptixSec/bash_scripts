#!/bin/bash

# Options for dmenu
options="Shutdown\nReboot\nLogout"

# Command to launch dmenu with the options
selected=$(echo -e "$options" | rofi -dmenu -i -p "Select action:")

# Perform the action based on the selected option
case $selected in
    Shutdown)
        systemctl poweroff
        ;;
    Reboot)
        systemctl reboot
        ;;
    Logout)
        # Command to logout from qtile
        qtile cmd-obj -o cmd -f shutdown
        ;;
    *)
        echo "No valid option selected."
        ;;
esac
