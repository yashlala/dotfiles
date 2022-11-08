if [[ -z $SSH_CLIENT ]] && [[ "$(tty)" == /dev/tty* ]]; then
  timeout 3s cmatrix -u 3
  sleep 0.01
  sway
fi
