#!/bin/bash

USERID=$(id -u)
if [ $USERID -ne 0 ]; then
    echo "Error : only root user can run this script"
    exit 1
else 
    echo "you are running with root access"

fi

dnf install mysql -y

if [ $? -eq 0 ]; then
    echo "MySQL installed successfully"
else
    echo "MySQL installation failed"
    exit 1
fi