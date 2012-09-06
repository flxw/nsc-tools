#!/bin/sh

source ./config/nsc-server.conf

echo "Symlinking pkg management scripts to $USER's home..."
/bin/ln -s "$PWD/download-pkgs" ~/
/bin/ln -s "$PWD/update-pkgs"   ~/ 

echo "Creating symlink in $USER's home to $REPO_DIR..."
/bin/ln -s "$REPO_DIR/nsc" ~/nsc_dir_link

# make the admin carry out these steps by hand
echo 'Please carry out the following steps by hand - as root!'
echo '# mkdir -p "$REPO_DIR/pacman-related/db'
echo '# sed "s:REPO_DIR:$REPO_DIR:" ./config/pacman.conf.template > "$REPO_DIR/pacman-related/pacman.conf"'
