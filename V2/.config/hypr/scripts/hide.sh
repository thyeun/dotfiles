#!/bin/bash

# 1. Save this file as $HOME/bin/bottom-edge.sh and make it executable
# 2. Put following in i3 config
# exec --no-startup-id xdotool behave_screen_edge --delay 300 --quiesce 300 bottom exec "$HOME/bin/bottom-edge.sh"

exec bash ~/.config/hypr/scripts/statusbar

CURSOR_STILL_NEAR_BOTTOM=1

# We want polybar to stay open until cursor moves away from its top edge
# You can use `xdotool getmouselocation` to figure out that position.
TOP_OF_BOTTOM_EDGE=2080

while [ "$CURSOR_STILL_NEAR_BOTTOM" -eq 1 ]; 
do
    Y_POS=$(xdotool getmouselocation | cut -d " " -f2 | cut -d ":" -f2)
    Y_POS=$(($Y_POS))
    if [ "$Y_POS" -lt "$TOP_OF_BOTTOM_EDGE" ]; then 
        CURSOR_STILL_NEAR_BOTTOM=0
    else
        sleep 0.05
    fi
done

killall -SIGUSR1 waybar