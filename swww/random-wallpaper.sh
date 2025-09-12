#!/bin/bash
wallpapersDir="$HOME/Pictures/Wallpapers"
wallpapers=("$wallpapersDir"/*)
if [ ${#wallpapers[@]} -eq 0 ]; then
    echo "No wallpapers found in $wallpapersDir"
    exit 1
fi
wallpaperIndex=$(( RANDOM % ${#wallpapers[@]} ))
selectedWallpaper="${wallpapers[$wallpaperIndex]}"
swww img "$selectedWallpaper" -t wipe --transition-duration=0.7 --transition-fps=120 
