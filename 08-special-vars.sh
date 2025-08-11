#!/bin/bash

echo "All veariables passed to the script: $@"
echo "Number of variables : $#"
echo "script name: $0"
echo "current directory: $PWD"
echo "current user: $USER"
echo "home directory: $HOME"
echo "PID of the script: $$"
sleep 10 & 
echo "PID of the last background process: $!"