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
Then, login as the new repository user and clone the repository into his home directory.

	# su repoman
	$ git clone git://github.com/n0stradamus/nsc-tools.git
	$ cd server

Now, edit `~/nsc-tools/server/config/nsc-server.conf` to your liking.
Afterwards, do (still as the repository user):

	$ cd ~/nsc-tools/server
	$ ./install.sh

The install script will create symlinks inside the users home
to the package management scripts from the repo.
Thus you can always stay up to date with a simple git-pull.

## repository setup
Now, you will have a directory, where the packages will be downloaded.
What is still missing is a mirrorlist and a sync database.
Installing a mirrorlist is very simple with [reflector](https://wiki.archlinux.org/index.php/Reflector).

Login as your repository user and do the following to create a 
new mirrorlist and update the repository's pacman sync database.

	$ source ~/nsc-tools/server/nsc-server.conf
	$ cd $REPO_DIR/pacman-related
	$ reflector -l 5 --sort rate --save mirrorlist
	$ sudo pacman --dbpath db --config pacman.conf --noconfirm -Syy

## cronjob setup
All that remains to be done is the cronjob setup, so updates are downloaded automatically.
To be able to update your clients once a day, put the following
in your repository user's crontab:

    0       3       *       *       *       ~/update-pkgs > /dev/null 

This will update the packages inside the repository every day at 3:00 AM.
Additionally, it will purge old and unneeded packages from the cache.

## SAMBA setup
Set up your SAMBA so that it shares the freshly created pacman cache
as a public read-only share. A minimal working example  of a SAMBA configuration could look like this:

    [global]
    workgroup     = WORKGROUP
    server string = my_cache_server
    netbios name  = my_cache_server
    security      = share

    [nsc]
    path = /srv/samba/myrepo
    read only = yes
    public = yes
    writable = no
    force user = nobody
