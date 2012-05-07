#!/bin/sh

source ./config/nsc-server.conf

# create repo
[ -d "$REPO_DIR" ] || mkdir -p "$REPO_DIR/db" "$REPO_DIR/nsc"

if [ $? != "0" ]; then
	echo "You will need to create $REPO_DIR using root privileges!"
	exit 1
fi

echo "Installing pacman.conf..."
sed "s:REPO_DIR:$REPO_DIR:" ./config/pacman.conf.template > "$REPO_DIR/nsc/pacman.conf"

echo "Installing pkg management scripts to $REPO_USER's home..."
install -m700 download-pkgs ~/
install -m700 remove-pkgs   ~/
install -m700 update-pkgs   ~/ 
