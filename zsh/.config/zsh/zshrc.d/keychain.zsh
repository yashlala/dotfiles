# automatically start/connect to 'ssh-agent' as needed.
if [ -z "$SSH_AGENT_SOCK" ] || [ -z "$SSH_AGENT_PID" ]; then
  if ! [ -d "$HOME/.cache/keychain" ]; then 
    mkdir -p "$HOME/.cache/keychain"
  fi
  eval $(keychain --noask --quiet --quick --absolute \
    --dir "$HOME/.cache/keychain" --eval)
fi
