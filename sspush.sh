#!/bin/bash
#
# sspush
# 
# A tool for macOS and Linux (Eventually) that pushes a screenshot/image 
# to a remote web server of your choosing via scp.
# 
# by mech
#

if [[ -n $1 && "$1" == "-n" ]]; then
	args="n"
fi

# Find the most recent file
# TODO set up arguments to push stuff outside of most recent screenshot
find_file() {
	ls -Art $SSFILEPATH | tail -n 1
}

# Genterate 8 random characters
random_name () {
	echo $RANDOM | md5sum | head -c 8; echo;
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
	echo "$BASELINK$(find_file)" | xclip -i
	echo "Link to file $BASELINK$(find_file)" # Feedback to see the link
else
	echo "Well...what is this then?"
fi
