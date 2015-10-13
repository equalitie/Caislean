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

# Prerequisites

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

Basic knowledge of Ansible (how to run a playbook) is also necessary.



