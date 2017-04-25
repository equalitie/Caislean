# Summary

## Description

This role installs OpenVPN and dnsmasq in order to allow clients to access the
Internet through the server.

It supports authentication either through the locally running LDAP server or
through the use of TLS certificates, or both.

## Prerequired roles

- `base-packages`
- `base-config`
- `tls`
- `openldap` (only if using the LDAP authentication)

# Manual steps: managing VPN clients access through TLS certificates

Clients need to produce TLS certification requests to be signed by your
certification authority. Hence, all machines need a working OpenSSL
installation. On Windows machines, OpenSSL is provided with the OpenVPN package.

## Authorizing a new client

### Step 1 (client machine): key and certificate signing request creation

The client that wishes to access the VPN must first generate a certificate
signing request (CSR), to be handed over to the VPN administrator.

#### Windows clients

[Install](https://openvpn.net/index.php/open-source/downloads.html) OpenVPN,
make sure all components are enabled at install-time. After installation, the
system may neet to be rebooted. In addition, the executable `C:\Program
Files\OpenVPN\bin\openvpn-gui.exe` may need to have explicit full administrator
privileges to run properly.

Run a command prompt with administrator privileges by typing `cmd` in the Start
menu search field and hitting `CTRL` + `SHIFT` + `ENTER`.

Move to the OpenVPN TLS directory and create a key and CSR:

    cd "C:\Program Files\OpenVPN\easy-rsa"
    openssl req -nodes -newkey rsa:4096 -keyout client.key.pem -out client.csr.pem

Hand over the file `C:\Program Files\OpenVPN\easy-rsa\client.csr.pem` to the VPN
administrator.

#### GNU/Linux clients

The CSR can be created this way:

    openssl req -nodes -newkey rsa:4096 -keyout client.key.pem -out client.csr.pem

The CSR is then in `client.csr.pem`.

### Step 2 (server administrator): certification of the new client with the CA certificate

From your local TLS tree (such as `/home/user/sec_comms_admin/tls`), issue the
following commands, where `request.csr.pem` is a certification request issued by
a client:

    export NSCERTTYPE="client" EKU="clientAuth"
    openssl ca -config openssl.cnf -in request.csr.pem -out certified.crt.pem

Make sure you keep a copy of the certificate produced, as it will be necessary
if revoking the access is needed. By default, a copy of each signed certificated
is written by `openssl` in the `certificates` subdirectory.

Hand over the newly signed certificate to the client (file `certified.crt.pem`),
as well as the root CA certificate (`ca.crt.pem`).

### Step 3 (client machine): Finalize OpenVPN configuration

Use the file `vpn-client/openvpn.conf.example.win32` (from this repository) as a
configuration template. Open the file in a text editor. If you run GNU/Linux,
rather use the `vpn-client/openvpn.conf.example.unix` sample file.

Put the content of `ca.crt.pem` between the `<ca>` and `</ca>` tags. Repeat the
operation for `certified.crt.pem` (both were provided by the VPN administrator),
between the `<cert>` and `</cert>` tags.

Repeat the operation with the file `client.key.pem` generated at step 1 and
located in `C:\Program Files\OpenVPN\easy-rsa`, this time between the tags
`<key>` and `</key>`.

Be careful not to add or remove any new-line character during the copy-paste
operations, or OpenVPN may fail in reading the certificates and key.

Change the value of the `remote` parameter to the address of the VPN server.

Save the file to `C:\Program Files\OpenVPN\config\sec_comms.ovpn`.

Start OpenVPN:

    Start Menu -> All Programs -> OpenVPN -> OpenVPN GUI

Right-click on the system tray icon that appeared and choose "Connect".

## Revoking access from a client

Move to your TLS management directory, such as
`/home/user/sec_comms_admin/tls/`, and identify the client certificate that you
want to revoke (you must have the `crt` file), for example `client.crt.pem`.

Revoke the certificate:

    export NSCERTTYPE="" EKU=""
    openssl ca -config openssl.cnf -revoke client.crt.pem

Generate a new CRL:

    openssl ca -config openssl.cnf -out crl.pem -gencrl

Move back to the repository root and use Ansible to update the CRL onto the
server.

# Configuration parameters (ansible variables)

## Mandatory parameters

### `openvpn_auth_mech`

Authentication mechanism for OpenVPN. Can be:

- `tls` to authenticate clients with their TLS certificates;
- `ldap` to authenticate clients with a login and password, against the
  locally-running OpenLDAP instance;
- `both` to perform both authentication, in which case a connecting client needs
  both a valid TLS certificate and valid credentials to connect.

### `openvpn_port`

Default: 1194

Port OpenVPN should be listening on.

### `openvpn_protocol`

Default: udp

Protocol for OpenVPN. Possible values are `udp` and `tcp`. Any other value will
make OpenVPN unable to start.

### `server_name`

The machine name of the administered server, e.g. "mycomputer".

### `domain_name`

The domain name, e.g. "mydomain.org".

## Optional parameters

### `auth_use_samba`

Can be set to either `true` or `false` (default). Defines whether LDAP
authentication should check credentials against the `samba` organisational unit
in the LDAP tree rather than the `mail` one. This option is only useful if you
are also using the `samba` role.

### `openvpn_listen_address`

Can be set to an IP address of the server that OpenVPN will be listening on, to
restrict the interfaces it listens on. By default, OpenVPN listens on all
network interfaces.
