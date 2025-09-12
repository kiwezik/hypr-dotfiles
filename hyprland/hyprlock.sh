#!/bin/bash
WALLPAPER_PATH=$(swww query | grep "DP-1" | awk -F'image: ' '{print $2}')
ESCAPED_PATH=$(printf '%s\n' "$WALLPAPER_PATH" | sed 's/[\/&]/\\&/g')
sed -i "s|^\([[:space:]]*path = \).*|\1$ESCAPED_PATH|" ~/hypr-dotfiles/hyprland/hyprlock.conf
hyprlock --immediate-render -c ~/hypr-dotfiles/hyprland/hyprlock.conf
