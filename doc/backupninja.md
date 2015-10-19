# Summary

## Description

## Prerequired roles

# Manual steps to setup backup system

GnuPG must be installed on your local machine.

A remote server accessible through SFTP with SSH key authentication must be
available.

## Create a PGP key pair for encrypting backups

A dedicated PGP keypair is necessary to secure the backups. Create, on your
local machine, a new key pair. For the example, we suppose the long ID (16 last
digits of the fingerprint) of this new key is `0x1234567890ABCDEF`.

Move to a directory dedicated to managing files related to the backup
management, for instance `/home/user/sec_comms_admin/backup_security/`, and
export both the public and private key to the same file `backup.key.pgp`:

    umask 077
    gpg -a --export 0x1234567890ABCDEF >backup.key.pgp
    gpg -a --export-secret-keys 0x1234567890ABCDEF >>backup.key.pgp

## Allow access from main server on the backup server

On your local machine (where Ansible runs), move into your backup management
directory and create an SSH keypair with an empty passphrase:

    cd /home/user/sec_comms_admin/backup_security/
    ssh-keygen -t rsa -b 4096 -N "" -f backup.key.ssh

Add the public key (stored locally in `backup.key.ssh.pub`) to the file
`/home/backup-user/.ssh/authorized_keys` on the backup server, with the
following syntax:

    command="/usr/lib/openssh/sftp-server",no-port-forwarding,no-X11-forwarding,no-agent-forwarding,no-pty ssh-rsa ....

We don't want to allow the user from changing this file or putting custom
`.bashrc` or `.profile` files that could execute arbitrary commands. We only
want the user to be able to upload and download their files. Hence, we need to
restrict the permissions. Issue the following commands as `root`:

    chown -R root:backup-user /home/backup-user
    chmod 0750 /home/backup-user/.ssh /home/backup-user
    chmod 0640 /home/backup-user/.ssh/authorized_keys
    rm -f /home/backup-user/.bash* /home/backup-user/.profile
    
Finally, create a subdirectory where the user has full read and write access to
put the files:

    mkdir /home/backup-user/backup
    chown backup-user:backup-user /home/backup-user/backup

`/home/backup-user/backup` is the directory that will be specified in the
Ansible configuration (see below).

## Collect the backup server's SSH public keys

On the backup server, display all the actual public keys with:

    cat /etc/ssh/ssh_host_*_key.pub | cut -d" " -f1,2

Each line corresponds to one public key. In the following parapgraph, we see how
to configure the Ansible installation with these keys.

# Configuration parameters (ansible variables)

## Mandatory parameters

### `backup_pgp_key_id`

Long ID of the PGP key used to encrypt, decrypt and sign the backups.

### `backup_pgp_passphrase`

The passphrase for the PGP key.

### `backup_security_directory`

Local directory containing the necessary backup-related files.

### `backup_remote_ssh_port`

SSH port for the host to backup to.

### `backup_remote_ip`

IP address of the host to backup to.

### `backup_remote_login`

User to login as onto remote backup system.

### `backup_remote_dir`

Directory where to put the backups in on the remote system.

### `backup_remote_ssh_keys`

List of public SSH keys of the backup server, as they would appear in a
SSH `known_hosts` file, listed following the YAML syntax, like for instance:

        backup_remote_ssh_keys:
	  - ssh-rsa AAAAB3NzaC1y....
	  - ssh-dss AAAAB3NzaC1kc...
	  - ecdsa-sha2-nistp256 AAAAE2Vj...

## Optional parameters

None.
