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
  writing a host variable files in the `host_vars` (see the example file);
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
