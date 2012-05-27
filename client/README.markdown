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

	# source /etc/nsc-tools/functions
    # push_pkglist_if_neccessary

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
