#!/bin/bash
#
# Simple bash script to look for some common issues preventing Ubuntu's
# unattended-upgrades from completing successfully.
#
echo ' ____   __  ____  ___  _  _        ___  _  _  ____  ___  __ _  ____  ____ ';
echo '(  _ \ / _\(_  _)/ __)/ )( \ ___  / __)/ )( \(  __)/ __)(  / )(  __)(  _ \';
echo ' ) __//    \ )( ( (__ ) __ ((___)( (__ ) __ ( ) _)( (__  )  (  ) _)  )   /';
echo '(__)  \_/\_/(__) \___)\_)(_/      \___)\_)(_/(____)\___)(__\_)(____)(__\_)';
echo '																			';

echo
echo -n "Provide your username (apike for example), followed by [ENTER]: "
read username

if [[ ! -z "${username// }" ]]; then
  echo -e "Username:\t\t		$username"
else
   echo "Username value entered is null.  Please enter a value."
   exit 0
fi

echo
echo -n "Provide the ticket number you are working from, followed by [ENTER]: "
read ticket

#re='^[0-9]+([.][0-9]+)?$'
re='^[0-9][0-9][0-9][0-9][0-9]?$'
if [[ $ticket =~ $re ]]; then
  echo -e "Ticket:\t\t			$ticket"
else
  echo "Ticket number entered is not valid.  Please enter another value."
  exit 0
fi

echo
echo "Creating working directory...."
echo

# if directory exists
HOME_DIR="/home/wirehive"
WORKING_DIR="$HOME_DIR/$username-$ticket"
if [ -d "$HOME_DIR" ]; then
  if [ ! -d "$WORKING_DIR" ]; then
    echo "Wirehive user exists!  Creating working directory:"
    echo "$WORKING_DIR"
    echo
    #echo "mkdir -pv $HOME_DIR/$username-$ticket;"
    mkdir -pv "$WORKING_DIR"
    #echo "cd $WORKING_DIR"
    cd "$WORKING_DIR"
  else
    echo "Directory $WORKING_DIR already exists!"
    echo "Using: $WORKING_DIR"
    cd "$WORKING_DIR"
  fi
else
  echo "Wirehive user does not exist!  Check why!"
  exit 0
fi

echo
echo "PATCHING CHECKER"
echo

if [ -f /etc/redhat-release ]; then
  echo "This is a Redhat/CentOS device and is currently not supported by this script"
  echo
fi

UBUNTUVER=$(/usr/bin/lsb_release -r | awk '{print $2}')
CRONDIR="/etc/cron.d"
PATCHCONF="wirehive_patching"

if [ -f /etc/lsb-release ]; then
  echo "OK:  Found Ubuntu"
  echo
  echo "Checking 'apt-get update' for issues...."
  /usr/bin/apt-get update > $WORKING_DIR/apt-get-update-output 2>&1
  if grep -s "Err" $WORKING_DIR/apt-get-update-output | grep -q vmware.com
  then
    echo "Error:  vmware error detected!"
      if [ -f /etc/apt/sources.list.d/packages_vmware_com_tools_esx_5_1latest_ubuntu.list ]; then
        echo
        echo "To fix, run:"
        echo "mkdir $WORKING_DIR;"
        echo "mv -v /etc/apt/sources.list.d/packages_vmware_com_tools_esx_5_1latest_ubuntu.list $WORKING_DIR/"
      else
        "Unable to find the vmware repository file.  Manually find, backup and remove."
      fi
  else
    echo "OK:  vmware error not detected."
  fi



  echo
  echo "Checking for patching configuration...."
  echo
  if [ -d "$CRONDIR" ]; then
    if [ ! -f $CRONDIR/$PATCHCONF ]; then
      echo "ERROR:  Patching is not configured!!"
      echo
      echo "Create the following file:"
      echo "$CRONDIR/$PATCHCONF"
      echo
      exit 2
    elif [ -x $CRONDIR/$PATCHCONF ]; then
      echo "OK:  Patching configuration file exists and is executable."
      echo
      echo "Check file contents is correct:"
      /bin/cat $CRONDIR/$PATCHCONF
      echo
    else
      echo "ERROR:  Patching configuration file exists but is not executable!"
      echo
      echo "To fix, run:"
      echo "/bin/chmod +x $CRONDIR/$PATCHCONF"
      exit 2
      echo
    fi
  fi

  echo "Performing Unattended Dry Run"
  echo
  STARTTIME=$(/bin/date +%Y-%m-%d" "%H:%M)
  /usr/bin/unattended-upgrades --dry-run -vvv > $WORKING_DIR/unattended-dry-run-output 2>&1 /dev/null
  ENDTIME=$(/bin/date +%Y-%m-%d" "%H:%M)
  awk "/$STARTTIME"/,/"$ENDTIME"/ /var/log/unattended-upgrades/unattended-upgrades.log > "$WORKING_DIR/awk-output"
  echo
  echo "Checking for errors:"
  if grep -s "has conffile prompt and needs to be upgraded manually" "$WORKING_DIR/unattended-dry-run-output"
  then
    echo "ERROR:  The following packages need to be manually installed:"
    grep -s "has conffile prompt and needs to be upgraded manually" "$WORKING_DIR/unattended-dry-run-output" | awk '{print $2}' | uniq | tr -d \'\" | tee /tmp/packages-to-install

  echo
  echo "To fix, run:"
  echo "apt-get install -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" --only-upgrade $(cat $WORKING_DIR/packages-to-install)"
  fi


  #/bin/cat /tmp/unattended-dry-run-output
  #echo
  #echo "Unattended Log Output:"
  #/bin/cat /tmp/awk-output
  echo

  if [ "$UBUNTUVER" == "16.04" ]; then
    echo "Ubuntu version 16.04 detected..."
    echo "Do 16.04 specific stuff...."
  elif [ "$UBUNTUVER" == "14.04" ]; then
    echo "Do 14.04 specific stuff..."
  elif [ "$UBUNTUVER" == "12.04" ]; then
    echo "Ubuntu 12.04 detected:  This is EOL!!!"
  fi
fi


