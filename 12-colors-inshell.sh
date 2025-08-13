#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

if [ $USERID -ne 0 ]
then
    echo -e "$R Error : only root user can run this script $N"
    exit 1
else 
    echo "you are running with root access"
fi
VALIDATE(){
    if [ $1 -eq 0 ]
    then
        echo -e "installing $2 is ...$G success $N"
    else
        echo -e "installing $2 is $R failed $N"
        exit 1
    fi
}
dnf list installed mysql
if [ $? -ne 0 ] 
then
    echo "MySQL is not installed, proceeding with installation"
    dnf install mysql -y
    VALIDATE $? "MySQL"
else
    echo -e "MySQL is $Y already installed nothing to do $N"
fi
dnf list installed python3
if [ $? -ne 0 ] 
then
    echo "python3 is not installed, proceeding with installation"
    dnf install python3 -y
    VALIDATE $? "python3"
    
else
    echo "python3 is already installed nothing to do"
fi