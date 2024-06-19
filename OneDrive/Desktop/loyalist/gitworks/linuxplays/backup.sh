#!/bin/bash

# Variables
SOURCE_DIR=$1
BACKUP_DIR=$2
LOG_FILE=/var/log/backup.log

# Functions
log() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") - $1" >> $LOG_FILE
}

# Check if both arguments are provided
if [ -z "$SOURCE_DIR" ] || [ -z "$BACKUP_DIR" ]; then
    echo "Usage: $0 <source_directory> <backup_directory>"
    exit 1
fi

# Check if source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: Source directory '$SOURCE_DIR' does not exist."
    log "Error: Source directory '$SOURCE_DIR' does not exist."
    exit 1
fi

# Create backup directory if it does not exist
if [ ! -d "$BACKUP_DIR" ]; then
    mkdir -p $BACKUP_DIR
    if [ $? -ne 0 ]; then
        echo "Error: Could not create backup directory '$BACKUP_DIR'."
        log "Error: Could not create backup directory '$BACKUP_DIR'."
        exit 1
    fi
fi

# Perform the backup using rsync
rsync -av --delete $SOURCE_DIR/ $BACKUP_DIR/
if [ $? -eq 0 ]; then
    echo "Backup of '$SOURCE_DIR' to '$BACKUP_DIR' completed successfully."
    log "Backup of '$SOURCE_DIR' to '$BACKUP_DIR' completed successfully."
else
    echo "Error: Backup failed."
    log "Error: Backup failed."
    exit 1
fi