#!/bin/bash

USERID=$(id -u)
if [ $USERID -ne 0 ]; then
    echo "Error : only root user can run this script"
    exit 1
else 
    echo "you are running with root access"
fi
VALIDATE(){
    if [ $1 -eq 0 ]; 
    then
        echo "installing $2 successfully"
    else
        echo "installing $2 installation failed"
        exit 1
    fi
dnf list installed mysql
if [ $? -ne 0 ]; 
then
    echo "MySQL is not installed, proceeding with installation"
    dnf install mysql -y
    VALIDATE $? "MySQL"
else
    echo "MySQL is already installedn nothing to do"
fi
dnf list installed python3
if [ $? -ne 0 ]; 
then
    echo "python3 is not installed, proceeding with installation"
    dnf install python3 -y
    VALIDATE $? "python3"
    
else
    echo "python3 is alrddeady installedn nothing to do"
fi