#!/bin/sh -e

# Prints a quote to stdout once per day. 
# TODO: make these quotes more inspirational/whimsical. 

cache_file="$HOME/.cache/daily-quote/run-date"
slowtype="$HOME/.local/scripts/slowtype.py"


cleanup () { 
  date -I >"$cache_file"
  exit 1
}
trap cleanup SIGINT

if [ -e "$cache_file" ]; then 
  last_date=$(cat "$cache_file")
else
  last_date="never"
  mkdir -p "$(dirname "$cache_file")"
fi

# Exit if we've already printed a quote today or it's not 6:30 AM yet.
if [ "$(date -I)" = "$last_date" ] \
    || [ "$(date '+%s')" -lt "$(date -d '06:30 Today' '+%s')" ]; then
  exit
fi

date -I >"$cache_file"

# don't consolidate the slowtypes; it changes the end-of-phrase delay. 
sleep 1
echo "Good Morning!" | "$slowtype"
echo -e "Here's a quote just for you:\n" | "$slowtype"
sleep 0.3
{ fortune -s -n 250; echo; } | "$slowtype"
sleep 0.3
echo "Remember to have a nice day!" | "$slowtype"
sleep 0.3