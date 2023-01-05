if [[ -z $SSH_CLIENT ]] && [[ "$(tty)" == /dev/tty* ]]; then
  sway
fi
