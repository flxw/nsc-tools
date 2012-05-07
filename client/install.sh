#!/bin/sh

if [ $UID != "0" ]; then
	echo "You need to be root to use this program! Exiting..."
	exit 1
fi

echo   "Installing to $PREFIX/usr/bin ..."
install -D -m544 remorem "$PREFIX/usr/bin"
install -D -m544 pullins "$PREFIX/usr/bin"
install -D -m544 pullup  "$PREFIX/usr/bin"