#!/bin/bash

# Directory containing your wallpapers
WALLPAPER_DIR="$HOME/Downloads/wallpapers"

# Index all files in the directory
wallpapers=("$WALLPAPER_DIR"/*)

# Use /dev/urandom to generate a more random index
random_index=$(od -An -N4 -tu4 < /dev/urandom | awk -v max="${#wallpapers[@]}" '{print $1 % max}')

# Choose a random wallpaper
random_wallpaper="${wallpapers[random_index]}"

# Use xwallpaper to set the wallpaper
xwallpaper --maximize "$random_wallpaper"