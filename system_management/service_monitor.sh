#!/bin/bash

source ../.env

services=('NetworkManager.service' 'cronie.service' 'dbus-broker.service' 'polkit.service' 'preload.service' 'sddm.service' 'dhcpcd@enp0s31f6.service' 'systemd-journald.service' 'systemd-logind.service' 'systemd-timesyncd.service' 'systemd-udevd.service' 'systemd-userdbd.service' 'udisks2.service' 'upower.service' 'ufw.service' 'postfix.service' 'suricata.service')

log_file="/var/log/service_monitor.log"
recipient="$MY_EMAIL"
email_subject="[$(date +"%d-%m-%Y %H:%M")] -> SERVICE MONITOR: "

restart_true="RESTART COMPLETED"
restart_false="RESTART FAILED"

log_alert() {
    echo "[$(date +"%d-%m-%Y %H:%M")] -> $1" >> "$log_file"
}

email_alert() {
    alerts+="$(date +"%d-%m-%Y %H:%M") -> $1"$'\n'
    email_subject+="$2 $3"
}

restart_service() {
    if systemctl restart "$1"; then
        log_alert "$1 $restart_true"
        email_alert "$1 $restart_true" "$1" "$restart_true"
    else
        log_alert "$1 $restart_false"
        email_alert "$1 $restart_false" "$1" "$restart_false"
    fi
}

alerts=""
for service in "${services[@]}"; do
    if ! systemctl is-active --quiet "$service"; then
        restart_service "$service" 
    fi
done

if [ -n "$alerts" ]; then
    echo "$alerts" | mail -s "$email_subject" "$recipient"
    wait
fi
