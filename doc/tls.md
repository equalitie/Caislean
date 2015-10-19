# Summary

## Description

## Prerequired roles

# Manual steps

## TLS certificates creation

Copy the empty TLS certicate management directory provided with the repository
into a local directory of your choice, for instance
`/home/user/caislean_admin/` and move to that directory:

    cp -Rn tls /home/user/caislean_admin
    cd /home/user/caislean_admin/tls/

Create the root CA certificate. It will be used both by the VPN server to
authenticate the connecting clients, as well as by the clients to authenticate
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

None.
