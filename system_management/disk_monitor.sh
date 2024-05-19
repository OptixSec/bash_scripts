#!/bin/bash

source ../.env

# Function to check disk usage for a given partition
check_disk_usage() {
    local partition="$1"
    local usage=$(df -h "$partition" | awk 'NR==2 {print $5}' | tr -d '%')
    echo "$usage"
}

# Function to send email if disk usage exceeds threshold
log_alert() {
    local partition="$1"
    local usage="$2"
    local recipient="$MY_EMAIL"
    local threshold=90
    local log_file="/var/log/disk_monitor.log"
    local alert="[$(date +"%d-%m-%Y %H:%M")] -> DISK MONITOR: DISK USAGE ABOVE $usage% -> $partition"

    if [ "$usage" -gt "$threshold" ]; then
        echo $alert >> "$log_file"
        echo $alert | mail -s "$alert" "$recipient"
    fi
}

# Main script
main() {
    local partitions=('/dev/sda3' '/dev/sda4')

    for partition in "${partitions[@]}"; do
        local usage=$(check_disk_usage "$partition")
        log_alert "$partition" "$usage"
        wait
    done
}

# Run the main script
main
