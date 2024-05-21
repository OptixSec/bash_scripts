#!/bin/bash

UPTIME_OUTPUT=$(uptime | awk '{print $3, $4}')
SPLIT_OUTPUT=' ' read -r part1 part2 <<< "$UPTIME_OUTPUT"

part2=${part2%,}

message="Uptime: $part1 $part2"

echo "$message"