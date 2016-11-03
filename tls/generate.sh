#!/usr/bin/bash
set -e
set -x
umask 0077
export NSCERTTYPE="" EKU=""
openssl req -config openssl.cnf -new -x509 -out ca.crt.pem -keyout ca.key.pem

openssl ca -config openssl.cnf -out crl.pem -gencrl
export NSCERTTYPE="server" EKU="serverAuth"
openssl req -config openssl.cnf -new -nodes -out server.csr.pem -keyout server.key.pem
openssl ca -config openssl.cnf -in server.csr.pem -out server.crt.pem
rm -f server.csr.pem
openssl dhparam -out dhparam.pem 2048
