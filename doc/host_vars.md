# What is this?

This file lists all the Ansible variables that are in use in Caisleán. Most
often, each host has its own host variables file in the `host_vars` directory,
with its own values for a subset of these variables. If you have no idea what
this means, take a look at the Ansible documentation on
[variables](https://docs.ansible.com/ansible/playbooks_variables.html).

Every variable is generally required by only a few roles. It may also be
optional. The "Required in" and "Optional in" statements below list the roles
for which each variable is required.

You will also find a list of all required variables in every role's
documentation file (see the `doc/role-doc/` directory).

# Variables for Caisleán

`admin_email`

An external e-mail address of the administrator, to send notifications (e.g.
available package upgrades) and security alerts (e.g. raised from rootkit
detectors) to.

Required in: `common`, `suricata`.

`auth_use_samba`

Set to `true` or `false` (default). Defines whether LDAP authentication should
check credentials against the `samba` organisational unit in the LDAP tree
rather than the `mail` one. This option is only useful if you are also using the
`samba` role.

Optional in: `openvpn`

`backup_pgp_key_id`

Long ID of the PGP key used to encrypt, decrypt and sign the backups.

Required in: `backupninja`

`backup_pgp_passphrase`

The passphrase for the PGP key.

Required in: `backupninja`

`backup_remote_dir`

Directory where to put the backups in on the remote system.

Required in: `backupninja`

`backup_remote_ip`

IP address of the host to backup to.

Required in: `backupninja`

`backup_remote_login`

User to login as onto remote backup system.

Required in: `backupninja`

`backup_remote_ssh_keys`

List of public SSH keys of the backup server, as they would appear in a
SSH `known_hosts` file, listed following the YAML syntax, like for instance:

    backup_remote_ssh_keys:
        - ssh-rsa AAAAB3NzaC1y....
	- ssh-dss AAAAB3NzaC1kc...
	- ecdsa-sha2-nistp256 AAAAE2Vj...

Required in: `backupninja`

`backup_remote_ssh_port`

SSH port for the host to backup to.

Required in: `backupninja`

`backup_security_directory`

Local directory containing the necessary backup-related files.

Required in: `backupninja`

`capture_traffic`

Set to `true` or `false`: whether or not to capture all the traffic into a PCAP
file, as permitted by the `pcap-log` output supported by Suricata.

Required in: `suricata`

`dkim_directory`

Local directory (on the machine on which Ansible is run) where DKIM keys are
stored.

Required in: `virtualmail`

`domain_name`

The domain part of the machine's fully qualified domain name, e.g.
"mydomain.org".

Required in: `ldap-account-manager`, `nginx`, `openldap`, `openvpn`, `prosody`,
`roundcube`, `samba`, `tls`, `usermin`, `virtualmail`, `wordpress`

`in_out_monitor_only`

Monitor only trafic that is emitted by or directed to the machine.

Required in: `suricata`

`ldap_admin_pass`

The local LDAP administrator password.

Required in: `openldap`, `samba`

`monitored_interfaces`

A list of network interfaces to monitor.

Required in: `suricata`

`mysql_root_password`

The local MySQL root password, i.e. the super-user of the local MySQL server.

Required in: `mysql`, `owncloud`, `wordpress`

`openvpn_auth_mech`

Authentication mechanism for OpenVPN. Can be:

- `tls` to authenticate clients with their TLS certificates;
- `ldap` to authenticate clients with a login and password, against the
  locally-running OpenLDAP instance;
- `both` to perform both authentication, in which case a connecting client needs
  both a valid TLS certificate and valid credentials to connect.

Required in: `openvpn`

`owncloud_mysql_password`

The MySQL password for user `owncloud` (this user is automatically created by
the role), who has access to the database associated with the local instance of
Owncloud.

Required in: `owncloud`

`samba_shares`

Defines a list of shares shown by Samba to clients. For each share, several
parameters are needed:

- `name`: name of the shared drive as it will appear to clients;
- `path`: the corresponding directory on the server;
- `valid_users`: list of valid users, following the syntax required by Samba's
  `valid users` parameter
- `caption` (defaults to `name`): comment of the shared drive;
- `create_mask` (defaults to "0600"): default permissions for newly created
    files in the given share
- `directory_mask` (defaults to "0700"): default permissions for newly
      created
        directories in the given share

Example:

    samba_shares:
        - name: Documents
          caption: Company documents
          path: /home/docs
          valid_users: "@Staff"
          create_mask: "0660"
          directory_mask: "0770"
        - name: Finance
          caption: Financial documents
          path:	/home/finance
          valid_users: "@Finance"
          create_mask: "0660"
          directory_mask: "0770"

Required in: `samba`

`server_addresses`

List of valid IP addresses that identify the server (used to determine whether
some trafic is emitted by or directed to the server).

Required in: `suricata`

`server_name`

The machine name of the administered server, e.g. "mycomputer".

Required in: `ldap-account-manager`, `nginx`, `openvpn`, `prosody`, `roundcube`,
`samba`, `tls`, `usermin`, `virtualmail`, `wordpress`

`tls_directory`

Local directory (on the machine running Ansible) where all the TLS files are
stored (certificates, keys and Diffie-Hellmann parameters).

Required in: `tls`

`wordpress_mysql_password`

The MySQL password for user `wordpress` (this user is automatically created by
the role), who has access to the database associated with the local instance of
Wordpress.

Required in: `wordpress`
