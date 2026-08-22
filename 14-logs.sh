#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
LOGS_FOLDER="/var/log/shellscript-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOGS_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"

mkdir -p $LOGS_FOLDER
echo "script statrted excuted at : $(date)" &>>$LOGS_FILE
if [ $USERID -ne 0 ]
then
    echo -e "$R Error : only root user can run this script $N" &>>$LOGS_FILE
    exit 1
else 
    echo "you are running with root access" &>>$LOGS_FILE
fi
VALIDATE(){
    if [ $1 -eq 0 ]
    then
        echo -e "installing $2 is ...$G success $N" &>>$LOGS_FILE
    else
        echo -e "installing $2 is $R failed $N" &>>$LOGS_FILE
        exit 1
    fi
}
dnf list installed mysql
if [ $? -ne 0 ] 
then
    echo "MySQL is not installed, proceeding with installation" &>>$LOGS_FILE
    dnf install mysql -y &>>$LOGS_FILE
    VALIDATE $? "MySQL"
else
    echo -e "MySQL is $Y already installed nothing to do $N" &>>$LOGS_FILE
fi
dnf list installed python3
if [ $? -ne 0 ] 
then
    echo "python3 is not installed, proceeding with installation" &>>$LOGS_FILE
    dnf install python3 -y &>>$LOGS_FILE
    VALIDATE $? "python3"
    
else
    echo "python3 is already installed nothing to do" &>>$LOGS_FILE