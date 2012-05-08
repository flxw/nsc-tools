#!/bin/sh

if [ $UID != "0" ]; then
	echo "You need to be root to use this program! Exiting..."
	exit 1
fi

echo   "Installing to $PREFIX/usr/bin ..."
install -D -m755 remorem "$PREFIX/usr/bin/remorem"
install -D -m755 pullins "$PREFIX/usr/bin/pullins"
install -D -m755 pullup  "$PREFIX/usr/bin/pullup"
