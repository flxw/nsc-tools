## Intro
This document will guide you through the process of setting up a client
with the nsc tools.

## Installing
Change to a temporary directory and clone the repository.
Then run the install script.

	# cd /tmp
	# git clone git://github.com/n0stradamus/nsc-tools.git
	# cd client
	# PREFIX="" ./install.sh

This will copy three scripts to `/usr/bin`, if no PREFIX is specified.
After having done that, edit the configuration in `client/config`
to your liking and save it to `/etc`:

	# vim client/config/nsc-client.conf
	# cp client/config/nsc-client.conf /etc

## Registering at the server
You need to have the login credentials for the repository user on the
server machine (you need to have it anyway).
This will try to update your machine. Even if no updates are installed,
the script will copy over a new list of packages to the server.
For now, this small bug will save us some work :)

	# pullup

Then, logon to the machine (as the repo user) and copy the file into `$REPO_DIR/nsc`.
On the server, do:

	# source ~/nsc-tools/server/config/nsc-server.conf
	# mv *.pkglist "$REPO_DIR/nsc"

## Usage

	pullins <packages>

To install packages. Will download them onto the remote cache.
After the download has finished, the cache will be mounted locally and 
the package(s) will be installed.

	remorem <packages>

This command will remove the package locally and push an updated
package list to the server.

	pullup

Will update the system using the remote caches sync db.
After the update, an updated package list will be pushed to the server.
