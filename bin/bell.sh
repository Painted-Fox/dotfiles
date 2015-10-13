#!/bin/sh
# Sends a bell notification.
# This helps test bell settings.
# You can send a bell every 10 seconds with the following:
#
#     watch -n10 bell.sh
#

echo -ne "\007" > /dev/tty
