# Caislean

*Caisleán - the Irish word for "castle". Pronounced "cash-lawn"*

Caislean is a set of [Ansible](https://www.ansible.com)
[recipes](https://docs.ansible.com/ansible/playbooks_intro.html) (also called
cookbook or playbook) that you can use to set up and manage in **few simple
steps** one or more servers offering free and open-source **tools for
communication and security** such as e-mail, a VPN and an instant messaging
service to communities and organizations.


## What does Caislean do?

Caislean helps system administrators to set up one or more
[secure](doc/security.md) servers **in few simple steps**.

The recipes install a set of free and open-source tools for communication,
file-sharing, secure Internet access and webhosting. Since Caislean is
**modular**, you can decide either to roll out all services or to just choose
the ones you need.

Furthermore, Caislean is designed to provide by default a good level of **basic
server security**, thanks to proper specific tweakings regarding TLS cipher
lists, web server security options, files and directories permissions and
ownership, etc.


## What services will the server offer?

If you point Caislean at a server, you will be able to offer several
[secure](doc/security.md) services to your users. The cookbook has a **modular
structure**, so you can choose to provide all the services listed below or just
some of them (see "How does Caislean work?" below for more details).

*  **Email**:  IMAP and SMTP over SSL via [Postfix](http://www.postfix.org/) and
   [Dovecot](http://dovecot.org/), with a webmail interface via
   [Roundcube](https://roundcube.net/).
*  **Jabber/XMPP** instant messaging via [Prosody](https://prosody.im/).
*  A **file hosting** service via [Owncloud](https://owncloud.org/).
*  A **webserver** via [Nginx](http://nginx.org/en/).
*  A [Wordpress](https://wordpress.org/)-based **blog**.
*  An [OpenVPN](https://openvpn.net/) server and
   [dnsmasq](http://www.thekelleys.org.uk/dnsmasq/doc.html) for Internet access
   through a **VPN**.


## Who is Caislean for?

Caislean requires basic system administration skills and can therefore be used
by anyone who has some familiarity with managing a server.

This makes it easy for single individuals, as well as for small groups and
organizations who cannot afford to hire a tech team (or prefer to rely solely on
volunteers) to have their own [secure](doc/security.md) server and to offer to a
number of users a set of tools for communication, file-sharing, secure Internet
access and webhosting.


## What do I need to use Caislean?


### Basic skills

Setting up and managing a server with Caislean requires familiarity with
GNU/Linux system administration, ease with the command line and some knowledge
of server security best practices.

It is also important to understand how [Ansible
cookbooks](https://docs.ansible.com/ansible/playbooks_intro.html) work, and
basic experience and understanding of the components that are going to be
installed is also recommended. For instance, if you choose to use Caislean to
install a mail server, you should know the basics of
[Postfix](http://www.postfix.org/) and [Dovecot](http://dovecot.org/), if you
intend to host a website or a blog, knowing the basics of
[Nginx](http://nginx.org/en/) is recommended, and so on.


### Technical requirements

*  One or more dedicated servers (the **target system**) with typical Debian
   requirements (see for instance the minimum hardware requirements for Debian
   [Wheezy](https://www.debian.org/releases/wheezy/amd64/ch03s04.html.en) and
   [Jessie](https://www.debian.org/releases/jessie/amd64/ch03s04.html.en)).  In
   general, requirements will vary depending on the services you offer and on
   the number of your users.
    *  To better take care of the users whose data you will be hosting, it is
       recommended to enable full disk encryption (FDE) on your target system.
       This can only be done when you install the system and requires full
       control over the Debian installation process (see the [server setup
       guide](doc/debian7-remote.md) for more information).
    *  Only Debian 7 (Wheezy) is supported at the moment.
    *  SSH access and access to root privileges are necessary.
    *  The packages `python` and `python-apt` are required.
    *  Read the [server setup guide](doc/debian7-remote.md) for more details on
       how to set up the target system.

*  A **local machine** to run Caislean.
    *  The machine where the recipes run must have
       [Ansible](https://www.ansible.com) installed in version 1.8 or more
       recent. It is packaged in most GNU/Linux distributions.
    *  Some components require the manual use of additional software such as
       OpenSSL and GnuPG.
    *  Indeed, you also need a copy of the Caislean git repository, that you can
       get through this command:

	    git clone https://github.com/equalitie/Caislean/


## How does Caislean work?

Once you have installed and set up your [target system](doc/debian7-remote.md)
and have everything you need in your local machine, have a look at the Caislean
directory you have just downloaded.

The repository follows the usual Ansible structure: each component sits in an
Ansible role, in the `roles` directory.

Caislean has a **modular structure**, which means that while certain roles are
necessary to run all or most of the services, other roles correspond to the
single services you may want to offer. So if, for example, you just want to
offer your users a Jabber/XMPP service and a VPN, your configuration files won't
have to include the roles that are needed for email and Wordpress.

In each role's detailed documentation (in the `role-doc` directory) you will
also find a list of the necessary roles that you need to launch for that module
to work. But to be sure, in the `doc` directory you will also find an [overview
of the roles](doc/roles_list.md) where roles that are fundamental for the server
to run correctly are separated from the roles for each single service.


## How to launch Caislean

After reading the documentation for each module you need to install, you can
start configuring your cookbook:

* write your inventory file (see [ansible_hosts.example](ansible_hosts.example)
  for a simple example);
* specify the components you want on each target system by writing a playbook
  (an example is given in [site.yml.example](site.yml.example)) that matches one
  or several hosts from your inventory file;
* configure the necessary variables required by the roles you selected by
  writing host variable files in the `host_vars` directory (see the example file
  in that directory): each role requires a number of variables to be set -- read
  the documentation for each role (in the `role-doc` directory) to learn how to
  configure the variables according to your needs;
* please, note that the roles you select may require a few manual steps: read
  the documentation to make sure you perform them all.

Once these steps are completed, run your cookbook from the root of the
repository tree:

	    ansible-playbook -i ansible_hosts site.yml

You may need to use some of these additional options on the command line,
depending on your case:

- `-u <user>` to specify the remote user to connect as;
- `-l <hostname or group>` to apply the cookbook just to one hostname or group
  defined in your inventory;
- `-K` to make Ansible prompt for a `su` or `sudo` password so that it obtains
  the right privileges on the target system.
* `-vvvv` to obtain a verbose output and check for errors.


## Contacts/Troubleshooting

To report a bug, ask questions or provide feedback of any kind, open an issue in
Caislean's [Github project](https://github.com/equalitie/Caislean/issues) or
write to: kheops@equalit.ie (PGP key: 0xBA5B6E9F53BB2174).
