#!/bin/bash

function error_if_not_exists {
  # Check if a file or directory exists
  if [ ! -f "$1" ]; then
    # If it does not exist, print an error message and exit
    echo "Error: $1 does not exist"
    exit 1
  fi
}

function copy_file {
  error_if_not_exists "$1"
  sudo cp "$1" "$2"
  echo "Copied $1 ---> $2"
}

# Make the restart_bms.sh script executable
error_if_not_exists "restart_bms.sh"
chmod +x restart_bms.sh
echo "Made restart_bms.sh executable"

# copy the restart_bms.sh script to /usr/local/bin
copy_file "./restart_bms.sh" "/usr/local/bin/restart_bms.sh"

# copy the restart_bms.service file to ~/.config/systemd/user
copy_file "./restart_bms.service" "$HOME/.config/systemd/user/restart_bms.service"

echo "Reloading systemd daemon"
systemctl --user daemon-reload

echo "Enabling and starting the restart_bms.service"
systemctl --user enable restart_bms.service

echo "Starting the restart_bms.service"
systemctl --user start restart_bms.service

echo "Checking the status of the restart_bms.service"
systemctl --user status restart_bms.service