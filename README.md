## Intro
If you use ArchLinux on several machines in your home network,
you'll often download the same packages several times for different machines
when doing a system update.

Wouldn't it be nice to have a central shared cache that always gives
you the newest packages without downloading any unneeded stuff?
If you own a device that can serve files over the network and is always
online, this project might be interesting for you.

## What capabilites do the nsc-tools provide?
The network device will serve packages through a read-only samba/NFS-share.
It will maintain package lists for each registered machine and will pull
updates if available.

On the client-side, three capabilities are provided:
* removing packages
* installing packages
* updating the system

If installing a package, the client will connect to the server using SSH
and initiate the package download on the server. If finished, the connection
is terminated and the shared cache is mounted. Then, the package is installed and
the cache is unmounted. Thus, you have a local package database and can still run
system updates if the network cache is down.

If removing a package, the client connects to the server and
removes the entry for the specific package from its package list.
That does not mean, that if you e.g. uninstall git, the other machines will not 
receive updates for git anymore. Each machine has its own package list on the server
to avoid that. Only if all systems don't use a specific package, it is not downloaded.

If updating a client, the share will simply be mounted and the updates will be installed.
Note that all these operations depend on the sync database of the server to provide
consistency. If your local sync database is more up to date than the servers,
an installation procedure would fail.
