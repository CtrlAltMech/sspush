# sspush - A screencapture and file sharing utility
sspush is intended to make it simple to upload and share screenshots/images/files via a public link that points to a server you own.

![Example](https://github.com/CtrlAltMech/sspush/assets/7492741/374c9dd4-efb4-4509-bcfa-66cfc7257354)

## Requirements

- A web-server you have access to.
- [SSH key pair](https://wiki.archlinux.org/title/SSH_keys) for web-server login.
- [xclip](https://github.com/astrand/xclip) locally (For Linux users using x11).
- [maim](https://github.com/naelstrof/maim) locally (For Linux users using x11).
- [slop](https://github.com/naelstrof/slop) locally (For Linux users using x11).
- [wl-clipboard](https://github.com/bugaevc/wl-clipboard) locally (For Linux users using Wayland).
- [grim](https://sr.ht/~emersion/grim/) locally (For Linux users using Wayland)
- [slurp](https://github.com/emersion/slurp) (For Linux users using Wayland)
- [screencapture](https://support.apple.com/en-us/HT201361) (Default on macOS)

## Installation

To use the sspush, follow the instructions below:

1. Clone the sspush repository to your local machine using the command: 
    
    `git clone https://github.com/CtrlAltMech/sspush.git`
    
2. Navigate to the cloned repository directory using the command `cd sspush`
3. Make the sspush script executable using the command `chmod +x sspush`
4. Run the script using the command `./sspush`

## Usage

1. On first use (when no config file is present) you will be prompted to generate an empty configuration file.

```
# Config file for sspush
 
# Filepath where screenshots are stored
SSFILEPATH=""

# Remote directory where screenshots are stored
REMOTEDIR=""

# Username for access to server
USERNAME="$USER"

# Private key location (script only works with ssh keys)
KEYPATH=""

# SSH port
PORT="22"

# Server IP or DNS name
SERVER=""

# Base link location (Link minus the image that the user will visit).
# Example https://mysite.net/pics/<your image name>.jpg"
BASELINK=""

# Allow/Deny desktop notifications
NOTIFICATIONS=""

# Specify which clipboard to use (clipboard or primary)
CLIPBOARD="clipboard"
```

2. Once the configuration file is created your editor should open to edit the file.
3. When the configuration file is filled out run the command again to push your file.
4. A link will be copied to your clipboard as well as printed out to the terminal.

## Flags :triangular_flag_on_post:
- `sspush` - Will post most recent file/screencapture in screenshots folder specified in config file. 
- `sspush -i <optional filename>` - Will start interactive mode allowing you to select a portion of the screen and post.
- `sspush -a <optional filename>` - Captures everything on all screens and posts.
- `sspush -h <optional filename>` - Prints syntax help out to terminal.

## Contributing :handshake:
I would love to hear if there are any bugs or a requested feature! :heart:

If you would like to contribute to the sspush project, follow the instructions below:

1. Fork the sspush repository to your Github account.
2. Clone your fork of the sspush repository to your local machine.
3. Make your changes to the sspush script.
4. Push your changes to your fork of the sspush repository.
5. Submit a pull request to the original sspush repository.

## License

The sspush bash script is released under the GNU General Public License v3.0. See the LICENSE file for more information.

## Stuff in the works
- Add video capture options
- Add desktop notifications option and an option to trigger your screenshot utility through the script.
- General code refactoring.
- Add color.
- Configuration sanitization.
- Format more according to [Google style guide](https://google.github.io/styleguide/shellguide.html#s7-naming-conventions)
