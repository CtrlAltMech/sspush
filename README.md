# sspush - A screenshot sharing utility

---

sspush is intended to make it simple to upload and share screenshots/images via a public link.

## Requirements

- ssh keys on local and remote machine (This will not work with a password login)
- xclip locally (For Linux users)
- scrot locally (Not currently in use yet, but will be in the development branch)
- A remote server you have access to

## Installation

To use the sspush bash, follow the instructions below:

1. Clone the sspush repository to your local machine using the command: 
    
    `git clone https://github.com/CtrlAltMech/sspush.git`
    
2. Navigate to the cloned repository directory using the command `cd sspush`
3. Make the sspush script executable using the command `chmod +x sspush`
4. Run the script using the command `./sspush`

## Usage

In its current state, sspush will only push the most recent file in your specified screenshots folder, and no arguments can be specified. More features will be available in the development branch, but may not work fully.

1. On first use (when no config file is present) you will be prompted to create one to generate the file.

```bash
# Config file for sspush

# Filepath where screenshots are stored
SSFILEPATH=""

# Remote directory where screenshots will be sent
REMOTEDIR=""

# Username for access to server
USERNAME=""

# Private key location (script only works with ssh keys)
KEYPATH=""

# SSH port
PORT=""

# Server IP or DNS name
SERVER=""

# Base link location (this is the link base that the user will visit. Example https://mysite.net/pics/<your image name>.jpg
BASELINK=""

# Allow/Deny desktop notifications (Not in use yet)
NOTIFICATIONS=""
```

2. Once the configuration file is created it will find the most recent file in the screenshots folder, rename it, and push it to the remote server.
3. A link will be created and printed to the screen as well as copied to your clipboard.

## Contributing

If you would like to contribute to the sspush project, follow the instructions below:

1. Fork the sspush repository to your Github account.
2. Clone your fork of the sspush repository to your local machine.
3. Make your changes to the sspush script.
4. Push your changes to your fork of the sspush repository.
5. Submit a pull request to the original sspush repository.

## License

The sspush bash script is released under the GNU General Public License v3.0. See the LICENSE file for more information.

## Stuff in the works

- Add argument/options to select a photo, desktop notifications, default image format.Add argument/options to select a photo, desktop notifications, default image format, option to trigger screenshot utility through script.
- Better error handling.
- General code refactoring
