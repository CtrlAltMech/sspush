#!/bin/bash
#
# sspush
# 
# A tool for macOS and Linux (Eventually) that pushes a screenshots/images(eventually) 
# to a remote web server of your choosing via scp.
# 
# To get this to work in macOS with a keybind you will need to setup a service
# in automator. Link to instructions below.
# https://dev.to/adamlombard/macos-run-a-script-in-any-app-via-custom-hotkey-4n99
# 
# by mech
#

# Source the configuration file
. $HOME/.sspushrc

# Configuration file location
CONFDIR="$HOME/.sspushrc"

#Starts interactive screencap and saves file
#TODO will add in the linux variant with proper statement.
screencapture -i ${SSFILEPATH}none.jpg

#Find the most recent file
find_file() {
	ls -Art $SSFILEPATH | tail -n 1
}

echo "Your most recent file is...$(find_file)"

#Update the name to 20 random characters
random_name () {
	echo $RANDOM | md5 | head -c 20; echo;
}


filename=$(basename "$SSFILEPATH/$(find_file)")

mv "${SSFILEPATH}$(find_file)" "${SSFILEPATH}$(random_name).${filename##*.}"

# Transfer the most recent file to the server
scp -i $KEYPATH ${SSFILEPATH}$(find_file) $USERNAME@$SERVER:$REMOTEDIR

# Copy to macOS clipboard
echo "https://thinkingdirt.net/pics/$(find_file)" | pbcopy

# Shows a notification that the file has been uploaded
osascript -e 'display notification "File '$(find_file)' Uploaded!"'

# If ran in terminal this will show the link in stdout
echo "Link to file https://thinkingdirt.net/pics/$(find_file)"
