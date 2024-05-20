#!/bin/bash

# Path to the file containing the list of conf files
LOG_FILES="$HOME/repos/bash/rofi_scripts/view_log/log_files.txt"

# Replace $HOME in the paths with the actual home directory path
LOG_PATHS=$(sed "s|\$HOME|$HOME|g" "$LOG_FILES")
echo "$LOG_PATHS"

# Use rofi (or dmenu) to select a configuration file from the list
SELECTED_LOG=$(echo "$LOG_PATHS" | rofi -dmenu -i -p "Edit log")

# Check if a file was selected
if [[ -n $SELECTED_LOG ]]; then
    # Extract the file path using awk (assuming the file paths are the last field in each line)
    log_file=$(echo "$SELECTED_LOG" | awk '{print $NF}')
    echo "Selected log file: $log_file"  # Debugging output
    kitty fish -c "cat \"$log_file\"; exec fish"
else
    echo "No file selected."
    exit 1
fi
