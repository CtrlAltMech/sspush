#!/bin/bash
#
# sspush
# 
# A tool for macOS and Linux (Eventually) that pushes a screenshot/image 
# to a remote web server of your choosing via scp.
# 
# by mech
#

# Source the configuration file
. $HOME/.sspushrc

# Determines what OS this is running on and will do something with that information
if [ "$(uname -s)" == "Darwin" ]; then
	echo "This is macOS"
elif [ "$(uname -s)" == "Linux" ]; then
	echo "This is Linux"
else
	echo "Well...what is this then?"

#Starts interactive screencap and saves file
#TODO Unable to get keybind to work properly in macOS, have not tried Linux yet.
# For now this will be triggered the usual way and sspush will need to be ran manually
#screencapture -i ${SSFILEPATH}none.jpg

#Find the most recent file
#TODO set up arguments to push stuff outside of most recent screenshot
find_file() {
	ls -Art $SSFILEPATH | tail -n 1
}

echo "Your most recent file is...$(find_file)"

#Update the name to 10 random characters
random_name () {
	echo $RANDOM | md5 | head -c 10; echo;
}


filename=$(basename "$SSFILEPATH/$(find_file)")

mv "${SSFILEPATH}$(find_file)" "${SSFILEPATH}$(random_name).${filename##*.}"

# Transfer the most recent file to the server
scp -i $KEYPATH ${SSFILEPATH}$(find_file) $USERNAME@$SERVER:$REMOTEDIR

# Copy to macOS clipboard
echo "$BASELINK$(find_file)" | pbcopy

# Shows a notification that the file has been uploaded
#TODO Set this as an option in the config
#osascript -e 'display notification "File '$(find_file)' Uploaded!"'

# If ran in terminal this will show the link in stdout
echo "Link to file https://thinkingdirt.net/pics/$(find_file)"
