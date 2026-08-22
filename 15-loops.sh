#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
LOGS_FOLDER="/var/log/shellscript-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOGS_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"
PACKAGES=("mysql" "python3")
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
#for package in ${PACKAGES[@]}#this is for sending arguments through script 
for package in $@ # this is for we get arguments from git bash
do 
    dnf list installed $package &>>$LOGS_FILE
    if [ $? -ne 0 ] 
    then
        echo "$package is not installed, proceeding with installation" | tee -a $LOGS_FILE
        dnf install $package -y &>>$LOGS_FILE
        VALIDATE $? "$package"
    else
        echo -e "$package is $Y already installed nothing to do $N" | tee -a $LOGS_FILE
    fi
done

