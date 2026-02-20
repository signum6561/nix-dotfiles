#!/bin/sh

podman system service -t 0 &
runsvdir "$HOME/.local/sv" &

if [ -z "$SSH_AUTH_SOCK" ]; then
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/signum_github &
fi

pipewire & 
fcitx5 &

# mako &
# waypaper --restore &
tailscale systray &

qs -c noctalia-shell &
