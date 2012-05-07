## Intro
This document will guide you through the process of setting up a client
with the nsc tools.

## Installing
Change to a temporary directory and clone the repository.
Then run the install script.

	# cd /tmp
	# git clone git://github.com/n0stradamus/nsc-tools.git
	# cd client
	# ./install.sh

This will copy three scripts to `/usr/bin`, if no PREFIX is specified.
After having done that, edit the configuration in `client/config`
to your liking and save it to `/etc`:

	# vim client/config/nsc-client.conf
	# cp client/config/nsc-client.conf /etc

## Registering at the server
It is not really a registration yet. You simply tell the server
what packages you have installed, so that it can pull the updates.
To do so, generate a list of packages and copy it over to the machine.

	# source /etc/nsc-client.conf
	# comm -23 <(pacman -Qeq|sort) <(pacman -Qmq|sort) > `hostname`.pkglist
	# scp `hostname`.pkglist "$REPO_USER@$REPO_IP"

Then, logon to the machine and copy the file into `$REPO_DIR/nsc`.
On the server:

	# source ~/nsc-tools/server/config/nsc-server.conf
	# mv *.pkglist "$REPO_DIR/nsc"

## Usage
After that, you can use:

* remorem, to remove packages
* pullins, to install packages
* pullup, to upgrade your system

Usage:

	remorem <packages>
	pullins <packages>
	pullup
