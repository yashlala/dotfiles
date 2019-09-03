#!/bin/sh

# This script serves as a wrapper around i3lock. This is
# necessary for DPMS support, as i3lock's built in DPMS
# handling has been deprecated since version 2.8. For more
# details, please see the manpage i3lock(1).

revert() {
  xset dpms 0 0 0
}

trap revert HUP INT TERM
xset +dpms dpms 5 5 5
i3lock -n "$@"
revert
