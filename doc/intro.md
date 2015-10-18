# What is Caisleán?

Caisleán is a set of [Ansible](https://www.ansible.com) recipes designed to ease
the setup and management of secure communication systems on a server. It aims at
helping a system administrator in setting up multiuser services such as e-mail,
virtual private network (VPN), instant messaging and others, for use by a
community of people.

The recipes are also designed to provide by default a good level of security
thanks to the proper specific tweakings being present, such as TLS cipher lists,
web server security options, files and directories permissions and ownership,
etc. This should not only save the time needed to system administrator to
properly dig into these settings but also give assurance that secure settings
are setup by default.

# Preparation

## Supported target systems

Target systems supported by the recipes are for the moment only Debian 7
(Wheezy).

## System running the recipes

The machine where the recipes run must have Ansible installed in version 1.8 or
more recent.

Some components require the manual use of additional software such as OpenSSL
and GnuPG.

## Knowledge

Setting up and managing systems with these recipes requires good knowledge of
GNU/Linux system administration and ease with the command line. The recipes are
not intented for use by unexperimented users.

It is also recommended to at least have basic experience and understanding of
the components that are going to be used.

Basic knowledge of Ansible is also necessary, i.e. knowing what the inventory
file is and writing a simple playbook (?) file.

# Using the playbooks

## Quick start

The repository follows the usual Ansible structure, and each component sits in
an Ansible role, in the `roles` directory. Getting started is as follows:

- write your inventory file (see `ansible_hosts.example` for a simple example);
- specify the components you want on each target system by writing a playbook
  (an example is given in `site.yml.example`) that matches one or several hosts
  from your inventory file;
- configure the necessary variables required by the roles you selected by
  writing host variable files in the `host_vars` directory (see the example
  file in that directory): each role requires a number of variables to be set,
  as specified by the documentation;
- the roles you select may require a few manual steps: read the documentation to
  make sure you perform them all.

Once these steps completed, run your playbook from the root of the repository
tree:

    ansible-playbook -i ansible_hosts site.yml

You may need to use some of these additional options on the command line,
depending on your case:

- `-u <user>` to specify the remote user to connect as;
- `-l <hostname or group>` to apply the playbook to only a hostname or group
  defined in your inventory;
- `-K` to make Ansible prompt for a `su` or `sudo` password so that it obtains
  the right priviledges on the target system.

## Overview of the roles

For detailed explanations, required manual steps and all available variables,
refer to each role's specific documentation.

Several roles depend on the presence of other ones within the same playbook in
order to run successfully: refer to their documentation to make sure you include
all necessary roles.

Roles are the following:

- `common`: basic system configuration hardening, including SSH, `sysctl`
  configuration and default file creation mask;
- `backupninja` (_work in progress_): backup system using backupninja and
  duplicity to a SFTP-enabled remote host;
- `tls`: system's TLS configuration (certificate, keys and revocation list),
  used by all network services;
- `openldap`: OpenLDAP installation and setup for basic multi-user support;
- `openvpn`: OpenVPN server and dnsmasq for Internet access through the VPN,
  with authentication to OpenLDAP and/or through TLS certificates;
- `virtualmail`: Postfix email server and dovecot SMTP server, authenticating
  against and delivering mails to LDAP users;
- `nginx`: basic nginx installation without any content;
- `php-fpm`: PHP-FPM service and configuration for a use with nginx and web
  services that require PHP;
- `mysql`: basic MySQL installation for use by web services;
- `ldap-account-manager` (_broken_): web-based management of LDAP user accounts;
- `owncloud`: Owncloud service and its configuration for nginx and PHP-FPM;
- `prosody`: Prosody XMPP server with authentication against local OpenLDAP;
- `roundcube`: Roundcube webmail client;
- `samba` (_work in progress_): Samba file sharing server, to be used through
  the VPN, with LDAP-based authentication;
- `suricata` (_broken_): Suricata Intrusion Detection System (IDS), to produce
  warnings in case of network-based attacks;
- `usermin` (_work in progress_): web-based usermin software to allow users to
  perform;
- `wordpress`: Wordpress installation and its configuration for ngins and
  PHP-FPM.
