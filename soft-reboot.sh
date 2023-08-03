#!/bin/sh

tmux new-session -d -s my_session '~/dev/osandell/scripts-linux/quit-hypr.sh && aplay ~/Downloads/file.wav && /usr/bin/reboot'

