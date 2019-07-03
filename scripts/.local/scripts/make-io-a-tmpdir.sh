#!/bin/sh

tmpdir=$HOME/io
# figure out later how to remove code redundancy with these bullshit
# escaping rules

if [ ! -e "$tmpdir" ] ; then
	ln -sfn "$(mktemp -d /tmp/io.XXX)" "$tmpdir"
	exit
fi 

if [ -L "$tmpdir" ] && [ ! -e "$tmpdir" ] ; then
	ln -sfn "$(mktemp -d /tmp/io.XXX)" "$tmpdir"
	exit
fi

echo "Error: Cannot symlink '~/io' to a temporary directory." >/dev/stderr
echo "       '~/io' exists and is not a broken symlink." >/dev/stderr
exit 1
