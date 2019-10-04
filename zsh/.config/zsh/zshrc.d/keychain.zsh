# automatically start/connect to 'ssh-agent' as needed.
if [ -n "$SSH_AGENT_SOCK" -a -n "$SSH_AGENT_PID" ]; then
  eval $(keychain --noask --quiet --quick --absolute \
    --dir "$HOME/.cache/keychain" --eval)
fi
