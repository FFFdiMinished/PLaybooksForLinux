#!/bin/bash

# Variables
USERNAME=$1
PASSWORD=$2

# Check if both username and password are provided
if [ -z "$USERNAME" ] || [ -z "$PASSWORD" ]; then
    echo "Usage: $0 <username> <password>"
    exit 1
fi

# Create the user and set the password
useradd -m $USERNAME
echo "$USERNAME:$PASSWORD" | chpasswd

# Check if the user was created successfully
if [ $? -eq 0 ]; then
    echo "User '$USERNAME' created successfully."
else
    echo "Error: Failed to create user '$USERNAME'."
fi
