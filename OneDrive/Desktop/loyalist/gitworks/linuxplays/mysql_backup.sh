#!/bin/bash

# Variables
USER="root"
PASSWORD="yourpassword"
DATABASE="yourdatabase"
BACKUP_DIR="/backup/mysql"
DATE=$(date +"%Y%m%d%H%M%S")
BACKUP_FILE="$BACKUP_DIR/$DATABASE-$DATE.sql.gz"

# Ensure the backup directory exists
mkdir -p $BACKUP_DIR

# Perform the database backup and compress the output
mysqldump -u $USER -p$PASSWORD $DATABASE | gzip > $BACKUP_FILE

# Check if the backup was successful
if [ $? -eq 0 ]; then
    echo "Backup of database '$DATABASE' completed successfully."
else
    echo "Error: Backup of database '$DATABASE' failed."
fi
