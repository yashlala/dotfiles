# automatically start/connect to 'ssh-agent' as needed.
eval $(keychain --noask --quiet --quick --absolute \
  --dir "$HOME/.cache/keychain" --eval)
