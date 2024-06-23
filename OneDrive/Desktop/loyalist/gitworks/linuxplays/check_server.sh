#!/bin/bash

# Variables
URL="http://example.com"
LOG_FILE="/var/log/server_status.log"

# Functions
log() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") - $1" >> $LOG_FILE
}

# Check the server status
STATUS=$(curl -o /dev/null -s -w "%{http_code}\n" $URL)

# Log the status
if [ $STATUS -eq 200 ]; then
    log "Server is up. Status code: $STATUS"
else
    log "Server is down or returned an error. Status code: $STATUS"
fi
