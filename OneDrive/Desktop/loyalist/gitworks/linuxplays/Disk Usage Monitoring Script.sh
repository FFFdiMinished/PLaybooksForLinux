#!/bin/bash

# Variables
THRESHOLD=80
LOG_FILE=/var/log/disk_usage.log

# Functions
log() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") - $1" >> $LOG_FILE
}

# Get the current disk usage percentage of the root filesystem
USAGE=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')

# Check if the usage exceeds the threshold
if [ $USAGE -gt $THRESHOLD ]; then
    MESSAGE="Warning: Disk usage is at ${USAGE}%"
    echo $MESSAGE
    log $MESSAGE
    # Here you could add more actions, like sending an email alert
else
    log "Disk usage is at ${USAGE}%, which is within the safe limit."
fi
