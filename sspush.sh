#!/bin/bash
#
# sspush
# 
# A tool for macOS and Linux (Eventually) that pushes a screenshot/image 
# to a remote web server of your choosing via scp.
# 
# by mech
#

CONFIG="$HOME/.sspushrc"
SSFILEPATH=
REMOTEDIR=
USERNAME=
KEYPATH=
PORT=
SERVER=
BASELINK=
INTERACTIVE=
OS= 

# If no configuration file is seen it will prompt to generate one 
confprompt () {
    read -p "$(echo -e 'No config file found. Would you like to create one? (y/n)\n> ')" confChoice
    
    while ! [[ $confChoice =~ (^y$|^Y$|^n$|^N$) ]]
    do
        read -p "Not a valid option. Would you like to create a config file? (y/n)\n> " confChoice
    done
    if [[ $confChoice =~ (^y$|^Y$) ]]; then
        echo "You do want to create a config file."
        confmake
    elif [[ "$confChoice" =~ (^n$|^N$) ]]; then
        echo "Goodbye!"
        exit 0
    fi
}

# Creates the configuration file
confmake () {
	
	read -p "Enter the path where you will store local screenshots: " SSFILEPATH
	read -p "Enter the remote directory the screenshots will be stored: " REMOTEDIR
	read -p "Enter your username for the remote server: " USERNAME
	read -p "Enter the path to your private ssh key: " KEYPATH
	read -p "Enter the ssh port you will be using: " PORT
	read -p "Enter the IP or domain name of remote server: " SERVER
	read -p	"$(echo -e 'Enter the Base link URL location (this is the link base that the user will visit.)\nExample https://mysite.net/pics/<your image name>.jpg\n> ')" BASELINK
	read -p "Do you want desktop notifications turned on? (y/n): " NOTIFICATIONS

	echo -e "\nLocal screenshot location: $SSFILEPATH"
	echo -e "Remote directory location: $REMOTEDIR"
	echo -e "Username for remote server: $USERNAME"
	echo -e "Path to private ssh key: $KEYPATH"
	echo -e "ssh port: $PORT"
	echo -e "IP or domain name of remote server: $SERVER"
	echo -e "Baselink URL: $BASELINK"
	echo -e "Desktop notifications on?: $NOTIFICATIONS\n"

	read -p "Does this look correct?(y/n): " confirmation

	if [[ $confirmation =~ (^y$|^Y$) ]]; then
		# This will create the file and put the information in
		touch $CONFIG
		echo -e "# Config file for sspush\n" >> $CONFIG
		echo -e "# Filepath where screenshots are stored" >> $CONFIG
		echo -e "SSFILEPATH=\"$SSFILEPATH\"\n" >> $CONFIG
		echo -e "# Remote directory where screenshots will be sent" >> $CONFIG
		echo -e "REMOTEDIR=\"$REMOTEDIR\"\n" >> $CONFIG
		echo -e "# Username for access to server" >> $CONFIG
		echo -e "USERNAME=\"$USERNAME\"\n" >> $CONFIG
		echo -e "# Private key location (script only works with ssh keys)" >> $CONFIG
		echo -e "KEYPATH=\"$KEYPATH\"\n" >> $CONFIG
		echo -e "# SSH port" >> $CONFIG
		echo -e "PORT=\"$PORT\"\n" >> $CONFIG
		echo -e "# Server IP or DNS name" >> $CONFIG
		echo -e "SERVER=\"$SERVER\"\n" >> $CONFIG
		echo -e "# Base link location (this is the link base that the user will visit. Example https://mysite.net/pics/<your image name>.jpg" >> $CONFIG
		echo -e "BASELINK=\"$BASELINK\"\n" >> $CONFIG
		echo -e "# Allow/Deny desktop notifications" >> $CONFIG
		echo -e "NOTIFICATIONS=\"$NOTIFICATIONS\"" >> $CONFIG
		echo -e "\nConfig file created!"

	elif [[ $confirmation =~ (^n$|^N$) ]]; then
		# This will prompt for ways to fix the issues
		echo "File not created!"
	else
		# Catch all for wrong input, might add a quit option
		echo "Wrong input format"
	fi
}

# Find the most recent file
find_file() {
	ls -Art $SSFILEPATH | tail -n 1
}

# Genterate 8 random characters
random_name () {
	echo $RANDOM | md5sum | head -c 8; echo;
}

# Checks what OS this running on
osCheck () {
	if [[ "$(uname -s)" == "Darwin" ]]; then
		OS="Darwin"
		echo "It's a mac"
	elif [ "$(uname -s)" == "Linux" ]; then
		OS="Linux"
		echo "Its a Linux"
	else
		echo "What the fuck is this then?"
		exit 0
	fi
}



# Find the most recent file
find_file() {
	ls -Art $SSFILEPATH | tail -n 1
}

# Genterate 8 random characters
random_name () {
	echo $RANDOM | md5sum | head -c 8; echo;
}

# Checks what OS this running on
osCheck () {
	if [[ "$(uname -s)" == "Darwin" ]]; then
		OS="Darwin"
		echo "It's a mac"
	elif [ "$(uname -s)" == "Linux" ]; then
		OS="Linux"
		echo "Its a Linux"
	else
		echo "What the fuck is this then?"
	fi
}

# Checks for configuration file
if [[ -f $CONFIG ]]; then
	echo "Your config file exists"
else
	echo "No conf found."
	confprompt
fi

# Source the configuration file
. $CONFIG

# Determines what OS this is running on and will do something with that information
if [[ "$(uname -s)" == "Darwin" ]]; then
	#Starts interactive screencap and saves file
	#TODO Unable to get keybind to work properly in macOS, have not tried Linux yet.
	# For now this will be triggered the usual way and sspush will need to be ran manually
	#screencapture -i ${SSFILEPATH}none.jpg
	echo "This is macOS"
	echo "Your most recent file is...$(find_file)"

	filename=$(basename "$SSFILEPATH/$(find_file)") # Finds the most recent file and stores it in the filename variable.
	mv "${SSFILEPATH}$(find_file)" "${SSFILEPATH}$(random_name).${filename##*.}" # Renames the file to random 8 character string
	scp -i $KEYPATH ${SSFILEPATH}$(find_file) $USERNAME@$SERVER:$REMOTEDIR # Transfer that file to the remote server
	echo "$BASELINK$(find_file)" | pbcopy # Copies to macOS keyboard
	echo "Link to file $BASELINK$(find_file)" # Feedback to see the link
	
	# Shows a notification that the file has been uploaded
	#TODO Set this as an option in the config
	if [[ "$args" == "n" ]]; then
		osascript -e 'display notification "File '$(find_file)' Uploaded!"'
	fi

elif [ "$(uname -s)" == "Linux" ]; then
	echo "This is Linux"
	echo "Your most recent file is...$(find_file)"

	filename=$(basename "$SSFILEPATH/$(find_file)") # Finds the most recent file and stores it in the filename variable.
	mv "${SSFILEPATH}$(find_file)" "${SSFILEPATH}$(random_name).${filename##*.}" # Renames the file to random 8 character string
	scp -i $KEYPATH ${SSFILEPATH}$(find_file) $USERNAME@$SERVER:$REMOTEDIR # Transfer that file to the remote server
	echo "$BASELINK$(find_file)" | xclip
	echo "Link to file $BASELINK$(find_file)" # Feedback to see the link
else
	echo "Well...what is this then?"
fi
