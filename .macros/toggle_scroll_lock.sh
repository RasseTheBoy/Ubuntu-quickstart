#!/bin/bash
# Creator: Rasmus Ohert

function notify_echo {
    echo -e "$1\a"
    notify-send "$1"
}


# Get the state of the Scroll Lock key
scroll_lock_state=$(xset q | grep "Scroll Lock:" | awk '{print $12}')

if [ "$scroll_lock_state" = "on" ]; then
    xset -led named "Scroll Lock"
    notify_echo "Scroll Lock turned OFF"
else
    xset led named "Scroll Lock"
    notify_echo "Scroll Lock turned ON"
fi