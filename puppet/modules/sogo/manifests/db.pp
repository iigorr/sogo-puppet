class sogo::db {

  $packages= ['mysql-server', 'mysql-client']

  package {$packages:
    ensure => installed,
  }

  service { 'mysql':
    ensure  => running,
    require => Package['mysql-server']    
  }

  exec { "create-db":
    unless  => "/usr/bin/mysql sogo",
    command => "/usr/bin/mysql -e \"create database sogo;\"",
    require => Service["mysql"],
  }

  exec { 'create-user':
    unless  => '/usr/bin/mysql -usogo -psogo',
    command => "/usr/bin/mysql -e \"create user 'sogo'@'localhost' identified by 'sogo' ;\"",
    require => Service["mysql"],
  }

  exec { "grant-rights":
    unless => '/usr/bin/mysql -usogo -psogo sogo',
    command => "/usr/bin/mysql -e \"grant all on sogo.* to sogo@localhost identified by 'sogo';\"",
    require => [Service["mysql"], Exec["create-user"], Exec["create-db"]]
  }

  exec { "create-user-table":
     unless => "/usr/bin/mysql -usogo -psogo sogo -e \"Show tables like 'sogo_users';\" | grep sogo_users",
    command => "/usr/bin/mysql -u sogo -psogo sogo -e \"CREATE TABLE IF NOT EXISTS sogo_users (c_uid VARCHAR(10) PRIMARY KEY, c_name VARCHAR(10), c_password VARCHAR(32), c_cn VARCHAR(128), mail VARCHAR(128));\"",
    require => [Service["mysql"], Exec["grant-rights"]]
  }

  exec { "create-igor-user":
    unless => "/usr/bin/mysql -usogo -psogo sogo -e \"select c_uid from sogo_users where c_uid='iigorr';\" | grep iigorr",
    command => "/usr/bin/mysql -u sogo -psogo sogo -e \"INSERT INTO sogo_users VALUES ('iigorr', 'iigorr', MD5('test'), 'Igor Lankin', 'igor@lankin.de');\"",
    require => [Service["mysql"], Exec["create-user-table"]]
  }
}