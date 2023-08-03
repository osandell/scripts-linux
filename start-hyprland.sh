export PATH="/home/olof/.local/bin:$PATH"
export XCURSOR_THEME=Adwaita

# This is needed for the gnome-keyring-daemon to work with ssh
eval $(/run/wrappers/bin/gnome-keyring-daemon --start --daemonize)
export SSH_AUTH_SOCK

Hyprland
