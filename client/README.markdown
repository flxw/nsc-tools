## Intro
This document will guide you through the process of setting up a client
with the nsc tools.

## Installing
Change to a temporary directory and clone the repository.
Change into the 'client' directory.

	# cd /tmp
	# git clone git://github.com/n0stradamus/nsc-tools.git
	# cd client
	# PREFIX="" ./install.sh

This will copy three scripts to `/usr/bin`, if no PREFIX is specified.
Now edit the configuration file located at `/etc/nsc-tools/nsc-client.conf`
(again, only if no PREFIX was specified). 

The file is well commented, so finding your way round should not be too hard.

## Registering at the server
For this step you need to have the login credentials of the user
we created on the repository server. Do the following to make the
server aware of the packages you have installed locally.

    # source /etc/nsc-tools/nsc-client.conf
	# comm -23 <(pacman -Qq|sort) <(pacman -Qmq|sort) > /tmp/`hostname`.pkglist
    # scp /tmp/`hostname`.pkglist "$REPO_USER@$REPO_IP:nsc_dir_link"
    # rm /tmp/`hostname`.pkglist

## Usage

    remopac <PACMAN_ARGUMENTS> [PACKAGES]

This command will wrap pacman functionality and simply make pacman use the network shared cache.
You can pass it the normal pacman arguments like '-Su' or '-Rscn'. Do NOT try to play
with pacmans '--config' or '--db' flag when using this script. You could seriously corrupt
your pacman database or make it invalid.
