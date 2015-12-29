# Overview of the roles

For each role there is a specific documentation file in the `role-doc` directory,
with detailed explanations, required manual steps and all available variables.

Several roles depend on the presence of other ones within the same playbook in
order to run successfully: refer to their documentation to make sure you include
all necessary roles.


## Basic roles

A list of all the roles that are necessary to run all or most of the services:

*  `common` sets up the most **basic system settings**, such as basic security,
   firewall and email address where the system should send warnings to;
*  `tls`: system's TLS configuration (certificate, keys and revocation list),
   used by all **network services**: email server, web server, VPN server, XMPP
   server;
*  `openldap`: OpenLDAP installation and setup for **basic multi-user support**;
   this module is needed for email and XMPP, and optionally for Owncloud and
   Wordpress;
*  modules necessary for most **web-based apps**:
    *  `php-fpm`: PHP-FPM service and configuration for use with nginx and web
       services that require PHP;
    *  `mysql`: basic MySQL installation for use by web services;
    *  `nginx`: basic nginx installation;

## Roles for the services

Caislean includes several modules, each one corresponding to one of the services
you may want your server to offer. You can include all or just some of them in
your cookbook configuration files, depending on your needs.

*  `virtualmail`: Postfix email server and dovecot SMTP server, authenticating
   against and delivering mails to LDAP users;
*  `roundcube`: Roundcube webmail client;
*  `prosody`: Prosody XMPP server with authentication against local OpenLDAP;
*  `owncloud`: Owncloud service and its configuration for nginx and PHP-FPM;
*  `wordpress`: Wordpress installation and its configuration for nginx and
   PHP-FPM.
*  `openvpn`: OpenVPN server and dnsmasq for Internet access through the VPN,
   with authentication to OpenLDAP and/or through TLS certificates;

## Roles in beta

These roles are finished in basic form but have not yet been tested widely

*  `letsencrypt`: replacement TLS certificates from the Let's Encrypt
   project - these are trusted by most modern browsers.

## Future roles

Some of the roles contained in this repository are unfinished, but will be ready
soon. Here's the complete list:

*  `backupninja`: backup system using backupninja and duplicity to a
   SFTP-enabled remote host;
*  `ldap-account-manager`: web-based management of LDAP user accounts;
*  `suricata`: Suricata Intrusion Detection System (IDS), to produce warnings in
   case of network-based attacks;
*  `usermin`: web-based usermin software to allow users to perform basic
   customization of their account;
*  `samba`: Samba file sharing server, to be used through the VPN, with
   LDAP-based authentication.
