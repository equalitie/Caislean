---
 
admin_email: user@domain.com
domain_name: domain.com
webmaster_email: webmaster@website.com
website_domain_name: website.com
server_name: caislean
tls_directory: /home/user/caislean_admin/tls
openvpn_auth_mech: tls
auth_use_samba: false
monitored_interfaces:
  - eth0
server_addresses:
  - 104.28.4.42
  - 104.28.5.42
  - 2a01:dead:beef:f00::0/64
in_out_monitor_only: true
capture_traffic: true
ldap_admin_pass: ldappassword
backup_security_directory: /home/user/caislean_admin/backup_security
backup_pgp_key_id: "0x1234567890ABCDEF"
backup_pgp_passphrase: StrongPassPhrase
backup_remote_ip: 1.2.4.5
backup_remote_ssh_port: 22
backup_remote_login: backup-user
backup_remote_dir: /home/backup-user
backup_remote_ssh_keys:
  - ssh-rsa AAAAB3NzaC1y....
  - ssh-dss AAAAB3NzaC1kc...
  - ecdsa-sha2-nistp256 AAAAE2Vj...
dkim_directory: /home/user/sec_comms_admin/dkim
mysql_root_password: MySQLPass
owncloud_mysql_password: OwncloudPass
wordpress_mysql_password: WordpressPass
