#!/bin/bash

echo ' ____   __  ____  ___  _  _        ___  _  _  ____  ___  __ _  ____  ____ ';
echo '(  _ \ / _\(_  _)/ __)/ )( \ ___  / __)/ )( \(  __)/ __)(  / )(  __)(  _ \';
echo ' ) __//    \ )( ( (__ ) __ ((___)( (__ ) __ ( ) _)( (__  )  (  ) _)  )   /';
echo '(__)  \_/\_/(__) \___)\_)(_/      \___)\_)(_/(____)\___)(__\_)(____)(__\_)';
echo '																			';

USERNAME=""
TICKET=""
DIRECTORY=$USERNAME-$TICKET
HOME="/home/wirehive"
PID=".dont-run.pid"

unset USERNAME
unset TICKET

while getopts u:t: option; do
  case ${option} in
    u | --username)
      USERNAME=${OPTARG}
      ;;
    t | --ticket)
      TICKET=${OPTARG}
      ;;
    *)
      echo $1: unknown option >&2
      exit 1
      ;;
  esac
done

if [ -f $PID ]; then
  echo "PID found! Checking for data...."
else
  echo "PID not found, checking to see if parameters were passed....."
fi


#if [ -z $USERNAME ] && [ -z $TICKET ]; then
#  echo "No parameters passed"
#  if [ -f $PID ]; then
#    echo "Found PID!"
#  fi
#elif [ ! -z $USERNAME ] && [ -z $TICKET ]; then
#  echo "Username provided but no ticket!"
#elif [ -z $USERNAME ] && [ ! -z $TICKET ]; then
#  echo "Ticket provided but not the username!"
#else
#  echo "Username and ticket provided!"
#  echo "$USERNAME"
#  echo "$TICKET"
#fi

#if [ -z "$USERNAME" ]; then
#  echo "No options received, checking for PID......"
#  exit
#fi



#echo $USERNAME-$TICKET








































































































































