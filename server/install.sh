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

echo "Linking pkg management scripts to $REPO_USER's home..."
/bin/ln "$PWD/download-pkgs" ~/
/bin/ln "$PWD/update-pkgs"   ~/ 

echo "Creating symlink in $REPO_USER's home to $REPO_DIR..."
/bin/ln -s "$REPO_DIR/nsc" ~/nsc_dir_link
