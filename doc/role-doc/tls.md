# Summary

## Description

This role installs to the server the TLS-related files specific to your
installation:

- your certification authority's public certificate;
- your server's public certificate (certified by the CA) and private key;
- a custom Diffie-Hellmann parameters file;
- a certificate revocation list.

All these files have to be created by yourself, manually, on your local system
from which you are running the playbook. The `tls/` directory at the root of
this repository provides a bare TLS management repository, with a pre-set
OpenSSL configuration file usable as is.

The playbook will upload them to the proper place onto the server, with the
correct permissions.

Note: at the moment, a change in your TLS files will not automatically trigger a
restart of your network services that provide TLS, and you need to restart them
manually.

## Prerequired roles

- `base-packages`

# Manual steps

## TLS certificates creation

Copy the empty TLS certicate management directory provided with the repository
into a local directory of your choice (see variable `tls_directory`), for
instance `/home/user/caislean_admin/` and move to that directory:

    cp -Rn tls /home/user/caislean_admin
    cd /home/user/caislean_admin/tls/

Create the root CA certificate. It will be used both by the VPN server to
authenticate the connecting clients and  by the clients to authenticate
the server.

    umask 0077
    export NSCERTTYPE="" EKU=""
    openssl req -config openssl.cnf -new -x509 -out ca.crt.pem -keyout ca.key.pem

Create an empty Certificate Revocation List:

    openssl ca -config openssl.cnf -out crl.pem -gencrl

Now create a certification request for your VPN server and certify it with your
new CA:

    export NSCERTTYPE="server" EKU="serverAuth"
    openssl req -config openssl.cnf -new -nodes -out server.csr.pem -keyout server.key.pem
    openssl ca -config openssl.cnf -in server.csr.pem -out server.crt.pem
    rm -f server.csr.pem

Finally, create Diffie-Hellmann parameters file:

    openssl dhparam -out dhparam.pem 2048

Note that the files `ca.crt.pem`, `ca.key.pem`, `server.crt.pem`,
`server.key.pem` and `dhparam.pem` must exactly have these respective names as
both the Ansible recipies and `openssl.cnf` use them.

# Configuration parameters (ansible variables)

## Mandatory parameters

### `server_name`

The machine name of the administered server, e.g. "mycomputer".

### `domain_name`

The domain name, e.g. "mydomain.org".

### `tls_directory`

Local directory where TLS files are stored (in the examples above, we used
`/home/user/caislean_admin/tls/`).

## Optional parameters

### `tls_additional_domains`

A set of domains for which you also want to upload to your server a certificate,
a certification authority certificate chain and a private key. This is at the
moment primarily useful for a web server serving several host names, and is used
in conjunction with the `nginx` role.

The TLS files for the specified domains must be located in your TLS directory
(see parameter `tls_directory` above) on your local machine and must exactly be
called `<host name>.ca.crt.pem` (for the certification authority certificate
chain), `<host name>.cert.crt.pem` (your certificate) and `<host name>.key.pem`
(your private key).

Do not use this parameter if you are planning to use Let's Encrypt. The
`letsencrypt` role will ignore domains listed in `tls_additional_domains`. See
`letsencrypt` role documentation for more details on using Let's Encrypt.

Example:

    tls_additional_domains:
      - www.otherdomain.com
