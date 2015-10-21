#
#    Copyright 2015 Mirantis, Inc.
#
#    Licensed under the Apache License, Version 2.0 (the "License"); you may
#    not use this file except in compliance with the License. You may obtain
#    a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
#    License for the specific language governing permissions and limitations
#    under the License.
#
 class plugin_zabbix::server::install {

  include plugin_zabbix::params

  file { '/etc/dbconfig-common':
    ensure    => directory,
    owner     => 'root',
    group     => 'root',
    mode      => '0755',
  }

  file { '/etc/dbconfig-common/zabbix-server-mysql.conf':
    ensure    => present,
    require   => File['/etc/dbconfig-common'],
    mode      => '0600',
    source    => 'puppet:///modules/plugin_zabbix/zabbix-server-mysql.conf',
  }

  plugin_zabbix::db::mysql_db { $plugin_zabbix::params::db_name:
    user     => $plugin_zabbix::params::db_user,
    password => $plugin_zabbix::params::db_password,
  }

  class { 'plugin_zabbix::db':
    db_ip       => $plugin_zabbix::params::db_ip,
    db_password => $plugin_zabbix::params::db_password,
    require     => Package[$plugin_zabbix::params::server_pkg],
    notify      => Service["${plugin_zabbix::params::server_service}"],
  }

  cron { 'zabbix db_clean':
    ensure      => 'present',
    require     => File[$plugin_zabbix::params::server_scripts],
    command     => "${plugin_zabbix::params::server_scripts}/db_clean.sh",
    user        => 'root',
    minute      => '*/5',
  }

  package { $plugin_zabbix::params::server_pkg:
    ensure    => present,
    require   => File['/etc/dbconfig-common/zabbix-server-mysql.conf'],
  }

  file { $plugin_zabbix::params::server_config:
    ensure    => present,
    require   => Package[$plugin_zabbix::params::server_pkg],
    content   => template($plugin_zabbix::params::server_config_template),
  }

  file { $plugin_zabbix::params::server_scripts:
    ensure    => directory,
    require   => Package[$plugin_zabbix::params::server_pkg],
    recurse   => true,
    purge     => true,
    force     => true,
    mode      => '0755',
    source    => 'puppet:///modules/plugin_zabbix/externalscripts',
  }

  if $plugin_zabbix::params::frontend {
    class { 'plugin_zabbix::frontend':
      require   => File[$plugin_zabbix::params::server_config],
    }
  }

  service { "${plugin_zabbix::params::server_service}":
    ensure    => running,
    name      => "${plugin_zabbix::params::server_service}",
    enable    => true,
  }

}
