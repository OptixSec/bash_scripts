#!/bin/bash

# Path to the file containing the list of conf files
CONF_FILES="$HOME/repos/bash/rofi_scripts/edit_conf/conf_files.txt"

# Replace $HOME in the paths with the actual home directory path
CONF_PATHS=$(sed "s|\$HOME|$HOME|g" "$CONF_FILES")
echo "$CONF_PATHS"

# Use rofi (or dmenu) to select a configuration file from the list
SELECTED_CONF=$(echo "$CONF_PATHS" | rofi -dmenu -i -p "Edit configuration")

# Check if a file was selected
if [[ -n $SELECTED_CONF ]]; then
    # Extract the file path using awk (assuming the file paths are the last field in each line)
    conf_file=$(echo "$SELECTED_CONF" | awk '{print $NF}')
    echo "Selected configuration file: $conf_file"  # Debugging output
    kitty chezmoi edit "$conf_file"
else
    echo "No file selected."
    exit 1
fi