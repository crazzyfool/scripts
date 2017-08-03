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


#if [ $# -ne 2 ];then
#  echo "$0: usage: checker-template [username] [ticket-id]"
#  exit 1
#fi


# If PID exists
if [[ -f $PID ]]; then
  if [[ $# -eq 2 ]]; then
    echo "PID file exists but you have supplied parameters.  Override PID? [Y/N]"
    read override
    if [[ $override == "Y" ]] || [[ $override == "y" ]]; then
      echo "TODO: run without looking at PID"
    elif [[ $override == "N" ]] || [[ $override == "n" ]]; then
      echo "TODO: run using information from PID"
    else
      echo "Should never happen!"
    fi
  fi
  # Extract information from PID
  if [[ $(cat "$PID" | wc -w) -ne 2 ]]; then
    echo "PID file exists but the contents is not understood. Remove? [Y/N]:"
    read remove
    if [[ $remove == "Y" ]] || [[ $remove == "y" ]]; then
      rm -v $PID
    else
      echo "Contents of PID not understood.  Please remove or correct the"
      echo "contents before running again"
    fi
  #elif [[ $(cat $PID | wc -w) -eq 2 ]]; then
  else
    echo "Found:"
    USERNAME=$(awk '{print $1}' $PID)
    TICKET=$(awk '{print $2}' $PID)
    echo "USERNAME=$USERNAME"
    echo "TICKET=$TICKET"
    echo
    echo "Looks like this has previously ran with the following details:"
    echo "Username:  $USERNAME"
    echo "Ticket:    $TICKET"
    echo
    echo "Re-run with these values? Answer 'yes' or 'no':"
    # Read response
    read answer
    # If 'yes':
    if [[ $answer == "yes" ]] || [[ $answer == "YES" ]] || [[ $answer == "Yes" ]]; then
      # Set username and ticket before re-running
      echo "Re-running as you said $answer!"
    # Else if 'no':
    elif [[ $answer == "no" ]] || [[ $answer == "NO" ]] || [[ $answer == "No" ]]; then
      # Prompt for new username and ticket ID:
      echo "Not re-running as you said $answer!"
    # Neither 'yes' or 'no'
    else
      #
      echo "I'm not sure what you replied with!!  Please enter either 'yes' or 'no'."
    fi

  fi
# If PID does not exist
else
  echo "No PID!"

fi



#validate_user() {
#  if [[ ! -z "${1// }" ]]; then
#    #echo -e "Username:\t\t      $1"
#    #echo -e "DEBUG:  User $1 is a valid (not null) user"
#    exit 0
#  else
#    echo "DEBUG:  Username is null.  Please enter a value"
#    exit 1
#  fi
#}
#
#validate_ticket() {
#  RE='^[0-9][0-9][0-9][0-9][0-9]?$'
#  if [[ "${1// }" =~ $RE ]]; then
#    #echo -e "Ticket:\t\t            $1"
#    #echo "DEBUG:  Ticket $1 is valid"
#    exit 0
#  else
#    #echo "Ticket number entered is not valid.  Please enter another value."
#    #echo "DEBUG:  Ticket $1 not valid"
#    exit 1
#  fi
#}
#
#
## check to see if checker has already been run:
#if [ -f .nocheck ]; then
#  echo "File .nocheck detected:"
#  cat .nocheck
#else
#  echo "Running!"
#  echo
#  echo -n "Provide your username (apike for example), followed by [ENTER]: "
#  read username
#  USERNAME=$username
#  echo
#  echo -n "Provide the ticket number you are working from, followed by [ENTER]: "
#  read ticket
#  TICKET=$ticket
#
#  #if validate_ticket $TICKET
#  #then
#  #  echo "OK:  $TICKET is a valid ticket"
#  #else
#  #  echo "ERROR:  Ticket number entered is not valid"
#  #fi
#
#  echo "DEBUG:  $username"
#  echo "DEBUG:  $ticket"
#  echo $(validate_user $username)
#
#  if [[ -z $(validate_user $username) ]]; then
#    echo "valid username"
#  else
#    echo "not valid"
#  fi
#
##  if [[ -z $(validate_user "${username}") ]]; then
##    echo "Valid username"
##    if [[ -z $(validate_ticket $ticket) ]]; then
##      echo "Valid ticket"
##    else
##      echo "Not a valid ticket"
##    fi
##  else
##    echo "Username not valid"
##  fi
#fi


