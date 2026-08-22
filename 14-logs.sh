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
echo "script statrted excuted at : $(date)" | tee -a $LOGS_FILE
if [ $USERID -ne 0 ]
then
    echo -e "$R Error : only root user can run this script $N" | tee -a $LOGS_FILE
    exit 1
else 
    echo "you are running with root access" | tee -a $LOGS_FILE
fi
VALIDATE(){
    if [ $1 -eq 0 ]
    then
        echo -e "installing $2 is ...$G success $N" | tee -a $LOGS_FILE
    else
        echo -e "installing $2 is $R failed $N" | tee -a $LOGS_FILE
        exit 1
    fi
}
dnf list installed mysql &>>$LOGS_FILE
if [ $? -ne 0 ] 
then
    echo "MySQL is not installed, proceeding with installation" | tee -a $LOGS_FILE
    dnf install mysql -y &>>$LOGS_FILE
    VALIDATE $? "MySQL"
else
    echo -e "MySQL is $Y already installed nothing to do $N" | tee -a $LOGS_FILE
fi
dnf list installed python3 &>>$LOGS_FILE
if [ $? -ne 0 ] 
then
    echo "python3 is not installed, proceeding with installation" | tee -a $LOGS_FILE
    dnf install python3 -y &>>$LOGS_FILE
    VALIDATE $? "python3"
else
    echo -e "nothing to do python $Y already installed $N" | tee -a $LOGS_FILE
fi