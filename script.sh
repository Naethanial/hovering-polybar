#!/bin/bash

POLYBAR_NAME="nathan" # put the name of your polybar
ACTIVATION_ZONE=10 # the distance within which you want the polybar to activate
SCREEN_HEIGHT=1200 # your screen height
WAIT_TIME=3.5 # time it takes for polybar to close
REFRESH=1 # how often you want it to check for cursor position

# Function to check if polybar is running
is_polybar_running() {
    pgrep -x polybar >/dev/null
}

while true; do
    # Get cursor position
    eval $(xdotool getmouselocation --shell)

    # Check cursor position
    if [ "$Y" -ge "$(($SCREEN_HEIGHT - $ACTIVATION_ZONE))" ]; then
        if ! is_polybar_running; then
            echo "Starting Polybar"
            polybar $POLYBAR_NAME &
            sleep 1 # Wait for polybar to start properly
        fi
    else
        if is_polybar_running; then
            echo "Stopping Polybar"
            # Start a background process that will kill polybar after wait time
            (
                sleep $WAIT_TIME
                killall polybar
                bspc config -m focused bottom_padding 0
            ) &
        fi
    fi

    # Wait before checking again
    sleep $REFRESH
done
