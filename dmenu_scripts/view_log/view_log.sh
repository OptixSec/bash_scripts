#!/bin/bash

# Path to the file containing the list of log files
LOG_FILES="$HOME/repos/bash/dmenu_scripts/view_log/log_files.txt"

# Use dmenu to select a log file from the list
SELECTED_LOG=$(cat "$LOG_FILES" | dmenu -i -l 20 -p "View log:")

# Check if a file was selected
if [[ -n $SELECTED_LOG ]]; then
    # View the selected file using Cat
    log_file=$(echo "$SELECTED_LOG" | awk '{print $NF}')
    kitty fish -c "cat \"$log_file\"; exec fish"
else
    echo "No file selected."
    exit 1
fi
