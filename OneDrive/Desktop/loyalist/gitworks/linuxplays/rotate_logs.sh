#!/bin/bash

# Variables
LOG_DIR="/var/log/myapp"
LOG_FILE="$LOG_DIR/app.log"
ARCHIVE_DIR="$LOG_DIR/archive"
DATE=$(date +"%Y%m%d%H%M%S")
ARCHIVE_FILE="$ARCHIVE_DIR/app-$DATE.log.gz"

# Ensure the archive directory exists
mkdir -p $ARCHIVE_DIR

# Rotate the log file
mv $LOG_FILE $ARCHIVE_FILE
gzip $ARCHIVE_FILE

# Create a new empty log file
touch $LOG_FILE

# Ensure the permissions are correct
chown myapp:myapp $LOG_FILE

# Check if the rotation was successful
if [ $? -eq 0 ]; then
    echo "Log rotation completed successfully."
else
    echo "Error: Log rotation failed."
fi
