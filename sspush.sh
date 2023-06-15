#!/bin/bash
#
# sspush
# 
# A tool for macOS and Linux (Eventually) that pushes a screenshot/image 
# to a remote web server of your choosing via scp.
# 
# by mech
#

SSFILEPATH=
REMOTEDIR=
USERNAME=
KEYPATH=
PORT=
SERVER=
BASELINK=
INTERACTIVE=
OS= 

# Checks for configuration file
if [[ -f $HOME/.sspushrc ]]; then
	echo "Your config file exists"
else
	echo "Not there dude"
	exit 0
fi

confprompt () {
    read -p "No config file found. Would you like to create one? (y/n)\n> " confChoice
    echo $confChoice
    while ! [[ $confChoice =~ (^y$|^Y$|^n$|^N$) ]]
    do
        read -p "Not a valid option. Would you like to create a config file? (y/n)\n> " confChoice
    done
    if [[ $confChoice =~ (^y$|^Y$) ]]; then
        echo "You do want to create a config file."
    elif [[ "$confChoice" =~ (^n$|^N$) ]]; then
        echo "You don't want to create a config file"
    fi
}

# Find the most recent file
# TODO set up arguments to push stuff outside of most recent screenshot
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

# Source the configuration file
. $HOME/.sspushrc



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
