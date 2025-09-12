#!/bin/bash
#	originally written by: gh0stzk - https://github.com/gh0stzk/dotfiles
#	rewritten for hyprland by :	 develcooking - https://github.com/develcooking/hyprland-dotfiles
#   if somethinks doesn't display or display bad (e.g. half of picture), try converting your png or what is it: magick convert ORIGINALFILE -strip -thumbnail 500x500^ OUTPUTFILE
#   also delete thumbnails in ~/.cache/jp/ORIGINFILE 

# Set some variables
wall_dir="${HOME}/Pictures/Wallpapers"
cacheDir="${HOME}/.cache/jp/${theme}"
rofi_command="rofi -dmenu -theme ${HOME}/hypr-dotfiles/swww/rofi-theme-wallpaper.rasi"

# Create cache dir if not exists
if [ ! -d "${cacheDir}" ] ; then
        mkdir -p "${cacheDir}"
    fi


physical_monitor_size=24
monitor_res=$(hyprctl monitors |grep -A2 Monitor |head -n 2 |awk '{print $1}' | grep -oE '^[0-9]+')
dotsperinch=$(echo "scale=2; $monitor_res / $physical_monitor_size" | bc | xargs printf "%.0f")
monitor_res=$(( $monitor_res * $physical_monitor_size / $dotsperinch ))

rofi_override="element-icon{size:${monitor_res}px;border-radius:0px;}"

# Convert images in directory and save to cache dir
for imagen in "$wall_dir"/*.{jpg,jpeg,png,webp}; do
    if [ -f "$imagen" ]; then
        nombre_archivo=$(basename "$imagen")
        if [ ! -f "${cacheDir}/${nombre_archivo}" ] ; then
            if ! magick convert -strip "$imagen" -thumbnail 500x500^ -gravity center -extent 500x500 "${cacheDir}/${nombre_archivo}"; then
                echo "error with $imagen" >&2
                convert -size 500x500 xc:gray -pointsize 20 -fill white -gravity center -annotate +0+0 "Error" "${cacheDir}/${nombre_archivo}"
            fi
        fi
    fi
done

# Select a picture with rofi
wall_selection=$(find "${wall_dir}" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) -exec basename {} \; | sort -V | while read -r A ; do echo -en "$A\x00icon\x1f""${cacheDir}"/"$A\n" ; done | $rofi_command)
# Set the wallpaper
[[ -n "$wall_selection" ]] || exit 1
swww img ${wall_dir}/${wall_selection} -t wipe --transition-duration=0.7 --transition-fps=120 

exit 0
