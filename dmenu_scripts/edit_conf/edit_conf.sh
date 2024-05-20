#!/bin/bash

# Path to the file containing the list of conf files
CONF_FILES="$HOME/repos/bash/dmenu_scripts/edit_conf/conf_files.txt"

# Use dmenu to select a configuration file from the list
SELECTED_CONF=$(sed "s|\$HOME|$HOME|g" "$CONF_FILES" | rofi -dmenu -i -p "Edit configuration")

# Check if a file was selected
if [[ -n $SELECTED_CONF ]]; then
    # Edit the selected file using Chezmoi
    conf_file=$(echo "$SELECTED_CONF" | awk '{print $NF}')
    kitty chezmoi edit "$conf_file"
else
    echo "No file selected."
    exit 1
fi
