#!/bin/bash

# Wait until the DBUS_SESSION_BUS_ADDRESS environment variable is available
while [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; do
  echo "Waiting for graphical session to initialize..."
  sleep 5
  DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$(pgrep -u "$USER" gnome-session)/environ | sed 's/DBUS_SESSION_BUS_ADDRESS=//')
  export DBUS_SESSION_BUS_ADDRESS
done

gnome-extensions disable blur-my-shell@aunetx
gnome-extensions enable blur-my-shell@aunetx