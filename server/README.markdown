## Intro
This document will guide you through setting up the remote cache
on your server.

## Remote user setup
First, create a new user that has the sole purpose of managing the cache.
Also, change the password.

	# useradd --create-home repoman
	# passwd repoman

Then, give your user permision to use pacman through sudo:

	# visudo

and add

	repoman ALL=(ALL) NOPASSWD: /usr/bin/pacman

Configure your ssh daemon, so that you can login as your repo user from outside
using password authentication.

## nsc-tools setup
Then, login as the new user and clone the repository into his home directory.

	# su repoman
	$ git clone git://github.com/n0stradamus/nsc-tools.git
	$ cd server

Now, edit `nsc-tools/server/config/nsc-server.conf` to your liking.
Then, do:

	$ cd ~/nsc-tools/server
	$ ./install.sh

The install script will create symlinks inside the users home
to the package management scripts from the repo.
Thus you can always stay up to date with a simple git-pull.

## repository setup
Now, you will have a directory, where the packages will be downloaded.
What is still missing is a mirrorlist and a sync database.
Installing a mirrorlist is very simple with [reflector](https://wiki.archlinux.org/index.php/Reflector).

Login as your repository user and do the following

	$ source ~/nsc-tools/server/nsc-server.config
	$ cd $REPO_DIR/nsc
	$ reflector -l 5 --sort rate --save mirrorlist
	$ cd ..
	$ sudo pacman --dbpath db --config nsc/pacman.conf --noconfirm -Syy
