#!/bin/sh

# This helper script is intended for use with urxvt's
# print-screen option (see `man -s1 urxvt` for details).

# This script reads a buffer from stdin, removes any
# trailing empty lines from the buffer, and then saves the
# result in a unique file with the current timestamp.

awk '/^$/ {nlstack=nlstack "\n";next;} \
  {printf "%s",nlstack; nlstack=""; print;}' \
    >"$(xdg-user-dir DOWNLOAD)/$(date +%F+%T).txt"
