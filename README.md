# sspush - A screencapture and file sharing utility

sspush is intended to make it simple to upload and share screenshots/images/files with no intervention from the user via a public link that points to a server you own.

![Example2](https://github.com/CtrlAltMech/sspush/assets/7492741/417a23ec-5c21-456e-9036-c2b68aebeef8)

## Requirements

- [web server](https://en.wikipedia.org/wiki/Web_server) remote server that you have access to.
- [SSH key pair](https://wiki.archlinux.org/title/SSH_keys) for web-server login.
- [xclip](https://github.com/astrand/xclip) locally (For Linux users using x11).
- [maim](https://github.com/naelstrof/maim) locally (For Linux users using x11).
- [slop](https://github.com/naelstrof/slop) locally (For Linux users using x11).
- [wl-clipboard](https://github.com/bugaevc/wl-clipboard) locally (For Linux users using Wayland).
- [grim](https://sr.ht/~emersion/grim/) locally (For Linux users using Wayland).
- [slurp](https://github.com/emersion/slurp) locally (For Linux users using Wayland).
- [wf-recorder](https://github.com/ammen99/wf-recorder) locally (For Linux users using Wayland).
- [screencapture](https://support.apple.com/en-us/HT201361) locally (Default on macOS).
- [libnotify](https://github.com/GNOME/libnotify) locally (For Linux users, only required if you need notifications).

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
- `sspush -v <optional filename>` - Captures video (Interactive capture ONLY on linux, Fullscreen ONLY on macOS)

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
- Dependency check (Setup for a couple of dependencies, need to work in the rest of them)
- General code refactoring.
- Configuration sanitization.
- Format more according to [Google style guide](https://google.github.io/styleguide/shellguide.html#s7-naming-conventions)
- Notifications for start/stop of video record if notifications are set to on in configuration file.
- Debug flag (for the video capture mainly, but other stuff as well.)
- Issue with portrait monitor video capture being treated like landscape mode in Wayland. Issue listed [here](https://github.com/ammen99/wf-recorder/issues/3). Needs a fix.

## Quirks
- Issue with Firefox in macOS, wayland, and X11 (3 different machines) not playing unless the pixel format was set to yuv420p. This has been set to run like this by default.
