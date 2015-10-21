Zabbix Plugin for Fuel
=======================

Zabbix plugin
--------------

Zabbix plugin for Fuel extends Mirantis OpenStack functionality by adding
Zabbix monitoring system. It installs Zabbix server, frontend and agent
components. The plugin configures Zabbix by adding templates to monitor nodes
and OpenStack services and APIs.

Requirements
------------

| Requirement                      | Version/Comment |
|:---------------------------------|:----------------|
| Mirantis OpenStack compatibility | >= 6.1          |

Installation Guide
==================

Building and installation
-------------------------

 How to build plugin:

 You can build plugin using the Fuel plugin builder tool: https://pypi.python.org/pypi/fuel-plugin-builder. Install fpb Python module:

    # [local-workstation]$ pip install fpb

 Install system packages fpb module reiles on:

 If you use Ubuntu, install packages createrepo rpm dpkg-dev
 If you use CentOS, install packages createrepo dpkg-devel dpkg-dev rpm rpm-build

 Clone plugin repository and run fpb there:

    # [local-workstation]$ git clone git@github.com:achekunov/fuel-plugin-external-zabbix.git -b on_external_node-7.0 && cd fuel-plugin-external-zabbix
    # [local-workstation]$ fpb --build ./

Zabbix plugin installation
---------------------------

To install Zabbix plugin, follow these steps:

1. Copy the plugin on already installed Fuel Master node; ssh can be used for
    that. If you do not have the Fuel Master node yet, see
    [Quick Start Guide](https://software.mirantis.com/quick-start/) :

        # scp zabbix_monitoring-2.0-2.0.0-1.noarch.rpm root@<Fuel_Master_ip>:/tmp

2. Install the plugin:

        # cd /tmp
        # fuel plugins --install zabbix_monitoring-2.0-2.0.0-1.noarch.rpm

3. Check if the plugin was installed successfully:

        # fuel plugins
        id | name              | version | package_version
        ---|-------------------|---------|----------------
        1  | zabbix_monitoring | 2.0.0   | 2.0.0

Zabbix plugin configuration
----------------------------

1. Create an environment.
2. Enable the plugin on the Settings tab of the Fuel web UI.
3. Check that "Install zabbix on external node" is selected
4. Optionally, change values in the form:
username/password - access credentials for Zabbix Administrator
database password - password for Zabbix database in MySQL
5. Assign "zabbix-new" role to the one of the node
6. Deploy the environment.
7. Zabbix frontend is available at: http://{ip_of_zabbix_node}/zabbix

For more information and instructions, see the Zabbix Plugin Guide in the
[Fuel Plugins Catalog](https://software.mirantis.com/fuel-plugins)

Release Notes
-------------

This is the first release of the plugin.

Contributors
------------

Dmitry Klenov <dklenov@mirantis.com> (PM)
Piotr Misiak <pmisiak@mirantis.com> (developer)
Szymon Bańka <sbanka@mirantis.com> (developer)
Bartosz Kupidura <bkupidura@mirantis.com> (developer)
Alexander Zatserklyany <azatserklyany@mirantis.com> (QA engineer)
