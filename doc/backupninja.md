# Role description

# Manual steps

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

(none)
