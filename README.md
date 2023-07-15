# sspush - A screencapture and file sharing utility
sspush is intended to make it simple to upload and share screenshots/images/files via a public link that points to a server you own.

![Example](https://github.com/CtrlAltMech/sspush/assets/7492741/1bafa0f3-9941-4f16-b2ad-031c2ceeab53)

## Requirements

- ssh keys on local and remote machine (This will not work with a password login).
- [xclip](https://github.com/astrand/xclip) locally (For Linux users).
- [wl-clipboard](https://github.com/bugaevc/wl-clipboard) locally (For Linux users on Wayland).
- [maim](https://github.com/naelstrof/maim) locally (For Linux users).
- [slop](https://github.com/naelstrof/slop) locally (For Linux users).
- [ffmpeg](https://ffmpeg.org/) locally (For Linux users).
- A remote server you have access to.

## Installation

To use the sspush, follow the instructions below:

1. Clone the sspush repository to your local machine using the command: 
    
    `git clone https://github.com/CtrlAltMech/sspush.git`
    
2. Navigate to the cloned repository directory using the command `cd sspush`
3. Make the sspush script executable using the command `chmod +x sspush`
4. Run the script using the command `./sspush`

## Usage

1. On first use (when no config file is present) you will be prompted to generate an empty configuration file.

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

2. Once the configuration file is generated you will need to enter all approprite information.
3. When the config is filled out run the script again and your file should upload.
4. A link will be copied to your clipboard as well as printed out to the terminal.

## Flags
`sspush` - Will post most recent file/screencapture in screenshots folder (If one exists).
`sspush -b <optional filename>` - Will post macbook touchbar.
`sspush -C <optional filename>` - Will post entire screen plus cursor.
`sspush -i <optional filename>` - Will start interactive mode allowing you to select a portion of the screen and post.
`sspush -m <optional filename>` - Will post only main monitor.
`sspush -v <optional filename>` - Will start video capture on main monitor and post when done.
`sspush -vg <optional filename>` - Will start video capture with mic capture and post when done.

## Contributing
I would love to hear if there are any bugs or a requested feature!

If you would like to contribute to the sspush project, follow the instructions below:

1. Fork the sspush repository to your Github account.
2. Clone your fork of the sspush repository to your local machine.
3. Make your changes to the sspush script.
4. Push your changes to your fork of the sspush repository.
5. Submit a pull request to the original sspush repository.

## License

The sspush bash script is released under the GNU General Public License v3.0. See the LICENSE file for more information.

## Stuff in the works

- Finish Linux functionality.
- Add desktop notifications option and an option to trigger your screenshot utility through the script.
- General code refactoring.
- Add color.
- Add help option.
- Format more according to [Google style guide](https://google.github.io/styleguide/shellguide.html#s7-naming-conventions)
