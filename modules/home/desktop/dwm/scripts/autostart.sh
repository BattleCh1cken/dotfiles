#!/bin/bash
feh --bg-fill ~/Pictures/wallpapers/wallpaper.png &
sh ~/.config/dwm/bar.sh </dev/null &>/dev/null &

xsetroot -cursor_name left_ptr
discord &
firefox &
mailspring &
