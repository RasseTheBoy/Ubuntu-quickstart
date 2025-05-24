# Restart blur-my-shell (BMS)

This script is used to restart the blur-my-shell (BMS) extension on startup. This is necessary because theres a weird conflict between the BMS extension and the "Just perfection" extension that causes the top bar to disappear. This script is a workaround to that issue.

## How to install

Just run the `install.sh` script in this directory. It will copy the files to their correct locations and setup the systemd service.

## TODO

The `.dektop` file doesn't seem to work. Need to figure out why, or just move back to the `.service` file (has worked before).
