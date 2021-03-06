#!/bin/bash

echo ' ____   __  ____  ___  _  _        ___  _  _  ____  ___  __ _  ____  ____ ';
echo '(  _ \ / _\(_  _)/ __)/ )( \ ___  / __)/ )( \(  __)/ __)(  / )(  __)(  _ \';
echo ' ) __//    \ )( ( (__ ) __ ((___)( (__ ) __ ( ) _)( (__  )  (  ) _)  )   /';
echo '(__)  \_/\_/(__) \___)\_)(_/      \___)\_)(_/(____)\___)(__\_)(____)(__\_)';
echo '										';

USERNAME=""
TICKET=""
DIRECTORY=$USERNAME-$TICKET
HOME="/home/wirehive"
PID=".dont-run.pid"

unset USERNAME
unset TICKET

while getopts u:t: option; do
  case ${option} in
    u )
      USERNAME=${OPTARG}
      ;;
    t )
      TICKET=${OPTARG}
      ;;
    *)
      echo $1: unknown option >&2
      exit 1
      ;;
  esac
done

# takes input and returns with trimmed leading and trailing white space
trim_white_space() {
  # trim space from input and return
  echo "$(echo -e "${1}" | tr -d '[:space:]')"
}


validateUsername() {
  # trim space from input
  TRIMMED_NAME="$(trim_white_space "$1")"

  # if input is not null
  if [[ ! -z "$TRIMMED_NAME" ]] && [[ "$TRIMMED_NAME" =~ ^[A-Za-z]+$ ]]; then
    #echo "not null and only contains letters!"
    #echo "Username=$TRIMMED_NAME"
    return 0
  # if input is null
  else
    #echo "null or contains numbers:"
    #echo "Username=$TRIMMED_NAME"
    return 2
  fi
}

#echo "validateUsername test:"
#echo " ap1ike "
#validateUsername " ap1ike "
#echo "(null)"
#validateUsername ""


if [[ "$(validateUsername '')" -eq 2 ]]; then
  echo "Success!"
elif [[ "$(validateUsername '')" -eq 0 ]]; then
  echo "Failed!"
else
  echo "Not sure what would cause this!!"
fi
  


getPidData() {
  if [ ! -f $PID ]; then
    echo "PID not found"
    exit 1
  else
    read -r firstline<$PID
    OPTS=$(echo $firstline | tr ":" " ")
    echo "OPTS: $OPTS"
    for i in $OPTS; do
      echo $i
    done
  fi
}


if [ -f $PID ]; then
  echo "PID found! Checking for data...."
  getPidData
  #read -r firstline<$PID
  #OPTS=$(echo $firstline | tr ":" " ")
  #echo "OPTS: $OPTS"
  #echo "firstline: $firstline"
  #echo $(echo $firstline | tr ":" " ")
  if [ ! -z "$OPTS" ] && [ $($OPT | wc -w) -le 2 ]; then
    echo "yay"
  fi
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






