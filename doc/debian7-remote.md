These instructions explain how to install Debian with full disk encryption (FDE)
on a remote server to which physical access is not possible.

# Requirements

Remote access to the screen and keyboard with KVM/IP is necessary in order to
access the Debian installer that normally appears when physically using the
machine.

Alternately, a
[method](http://markus.heberling.net/2014/09/10/install-custom-operating-systems-on-soyoustart-com/)
without KVM/IP exists if your hosting provider enables you to boot your machine
on a rescue GNU/Linux system loaded into the RAM of your machine. This is
notably the case for OVH/SoYouStart.

# Debian Installation process

For disk partitioning, select "_Use entire disk and set up encrypted LVM_". Make
sure you use a secure passphrase.

After partitioning the disk and installing basic packages, the "Software
Selection" dialog will open. Only check _SSH server_ and _Standard system
utilities_, leave the rest unchecked.

At the end of the installation process, when it asks for reboot, choose "Go
back" and select "Execute a shell". Then, run these commands to obtain `root`
access to the system being installed:

    chroot /target/
    mount /proc
    mount /sys
    bash

Install the `dropbear` package:

    aptitude install dropbear

Copy your SSH public key to the non-root user's authorized keys file, in
`/home/user/.ssh/authorized_keys`. Make sure this file belongs to the user,
not root, with the right permissions.

Copy your SSH public key a second time, to the file
`/etc/initramfs-tools/root/.ssh/authorized_keys`. Edit that file and prepend
the following string at the very beginning of the file, before `ssh-rsa`:

    command="cat - >/lib/cryptsetup/passfifo" 

Unless your hoster provides DHCP, setup a static IP configuration in
`/etc/initramfs-tools/initramfs.conf`, by adding a line that follows this
syntax:

    IP=<local_IP>::<gw_IP>:<netmask>:<hostname>:<network_interface>:off

where (you can find examples
[here](https://projectgus.com/2013/05/encrypted-rootfs-over-ssh-with-debian-wheezy/)):

- `<local_IP>` is the public IP address assigned to your server
- `<gw_IP>` is your hoster's Internet gateway IP address
- `<netmask>` is your host's network mask using an IP format (your public IP
  and the gateway IP must be in the same subnet)
- `<hostname>` is your server's hostname, as you configured during the
  installation process
- `<network_interface>` is the network interface name connected to the
  Internet, typically `eth0` (check this using `ip address show up`)

Run this command to ensure the network is enabled within the initramfs (change
`eth0` to your actual network interface name if necessary):

    grep DRIVER= /sys/class/net/eth0/device/uevent | cut -d= -f2 >>/etc/initramfs-tools/modules

Rebuild the initramfs:

    update-initramfs -u

The file `/etc/rc.local` needs a little tweeking to ensure the network
is setup properly: add these lines to the file, before the line `exit 0`:

        ifdown -a
	ifup -a

Exit the shell, you will have to type `exit` three times.

Select "Finish the installation".

# Finish installation

Reboot the server when the installation is complete. When the initramfs starts,
it should setup its network configuration and start the dropbear SSH server.

Unlock the root disk from your machine using this command:

    echo -n yourpassphrase|ssh -o UserKnownHostsFile=~/.ssh/known_hosts.initramfs root@yourserver

The system will startup as soon as the root disk has been successfully unlocked.
Once it has finished booting, it is possible to login using:

    ssh username@yourserver

