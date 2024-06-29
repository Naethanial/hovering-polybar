#!/bin/bash

POLYBAR_NAME="nathan" #put the name of your polybar
ACTIVATION_ZONE=15  #the ditance in within you want the polybar to activate
SCREEN_HEIGHT=1440  #your screen height 
POLYBAR_RUNNING=false #boolean
WAIT_TIME=1 # time it takes for polybar to close

while true; do
  # cursor
  eval $(xdotool getmouselocation --shell)
  
  # check
  if [ "$Y" -ge "$(($SCREEN_HEIGHT - $ACTIVATION_ZONE))" ]; then
    if ! $POLYBAR_RUNNING; then
      echo "Starting Polybar"
      polybar $POLYBAR_NAME &
      POLYBAR_RUNNING=true
    fi
  else
    if $POLYBAR_RUNNING; then
      echo "Stopping Polybar"
      sleep ${WAIT_TIME}s && killall polybar && bspc config -m focused bottom_padding 0 & 
      POLYBAR_RUNNING=false
    fi
  fi
  
  sleep 0.1  # refresh rate
done
