#!/bin/bash

# Locks the session with i3lock. If XSS tells us the
# computer is about to sleep, then delay sleep until the
# screen is locked by handing over the XSS_SCREEN_LOCK file
# descriptor. This script is intended for use with xss-lock,
# but functions as a standalone script; if no XSS file
# descriptor is passed, the script will still invoke i3lock.

## CONFIGURATION ##

# Location of the i3lock wrapper script
i3lock_command="$HOME/.local/scripts/i3lock.sh"

# Options to pass to i3lock
i3lock_options='--ignore-empty-password --pass-media-keys'

# Run before starting the locker
pre_lock() {
  if [[ -e "$HOME/.local/share/mpd/pid" ]]; then
    music_playing=true
    mpc pause
  fi
  return
}

# Run after the locker exits
post_lock() {
  if [[ -z "$music_playing" ]]; then
    mpc seekthrough -5
    mpc play
  fi
    return
}

###################

pre_lock

# We set a trap to kill the locker if we get killed, then
# start the locker and wait for it to exit. The waiting is
# not that straightforward when the locker forks, so we use
# this polling only if we have a sleep lock to deal with.

if [[ -e /dev/fd/${XSS_SLEEP_LOCK_FD:--1} ]]; then
    kill_i3lock() {
        pkill -xu $EUID "$@" $i3lock_command
    }

    trap kill_i3lock TERM INT

    # we have to make sure the locker does not inherit a
    # copy of the lock fd
    $i3lock_command $i3lock_options {XSS_SLEEP_LOCK_FD}<&-

    # now close our fd (only remaining copy) to indicate
    # we're ready to sleep
    exec {XSS_SLEEP_LOCK_FD}<&-

    while kill_i3lock -0; do
        sleep 0.5
    done
else
    trap 'kill %%' TERM INT
    $i3lock_command -n $i3lock_options &
    wait
fi

post_lock
