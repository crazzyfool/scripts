#!/bin/bash

echo ' ____   __  ____  ___  _  _        ___  _  _  ____  ___  __ _  ____  ____ ';
echo '(  _ \ / _\(_  _)/ __)/ )( \ ___  / __)/ )( \(  __)/ __)(  / )(  __)(  _ \';
echo ' ) __//    \ )( ( (__ ) __ ((___)( (__ ) __ ( ) _)( (__  )  (  ) _)  )   /';
echo '(__)  \_/\_/(__) \___)\_)(_/      \___)\_)(_/(____)\___)(__\_)(____)(__\_)';
echo '																			';

USERNAME=
TICKET=

validate_user() {
  if [[ ! -z "${1// }" ]]; then
    #echo -e "Username:\t\t      $1"
    echo -e "DEBUG:  User $1 is a valid (not null) user"
    exit 0
  else
    echo "DEBUG:  Username is null.  Please enter a value"
    exit 1
  fi
}

validate_ticket() {
  RE='^[0-9][0-9][0-9][0-9][0-9]?$'
  if [[ "${1// }" =~ $RE ]]; then
    #echo -e "Ticket:\t\t            $1"
    echo "DEBUG:  Ticket $1 is valid"
    #exit 0
  else
    #echo "Ticket number entered is not valid.  Please enter another value."
    echo "DEBUG:  Ticket $1 not valid"
    #exit 1
  fi
}


# check to see if checker has already been run:
if [ -f .nocheck ]; then
  echo "File .nocheck detected:"
  cat .nocheck
else
  echo
  echo -n "Provide your username (apike for example), followed by [ENTER]: "
  read username
  USERNAME=$username
  echo
  echo -n "Provide the ticket number you are working from, followed by [ENTER]: "
  read ticket
  TICKET=$ticket

  #if validate_ticket $TICKET
  #then
  #  echo "OK:  $TICKET is a valid ticket"
  #else
  #  echo "ERROR:  Ticket number entered is not valid"
  #fi

  echo "DEBUG:  $username"
  echo "DEBUG:  $ticket"


#  if [[ -z $(validate_user "${username}") ]]; then
#    echo "Valid username"
#    if [[ -z $(validate_ticket $ticket) ]]; then
#      echo "Valid ticket"
#    else
#      echo "Not a valid ticket"
#    fi
#  else
#    echo "Username not valid"
#  fi
fi



