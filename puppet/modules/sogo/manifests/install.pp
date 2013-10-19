class sogo::install {
  
  file { '/etc/apt/sources.list.d/sogo.list':
    ensure  => file,
    owner   => root,
    group   => root,
    source  => 'puppet:///modules/sogo/sogo.list',
  }

  exec {'add-sogo-key':
    path      => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    command   => 'apt-key adv --keyserver keys.gnupg.net --recv-key 0x810273C4',
    subscribe => File['/etc/apt/sources.list.d/sogo.list'],
  }

  exec { 'apt-update-sogo':
    path      => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    command   => 'apt-get update',
    require => Exec['add-sogo-key'],
  }

  package { 'sope4.9-gdl1-mysql':
    ensure => installed,
    require => Exec['apt-update-sogo'],
  }
  
  package { 'sogo':
    ensure  => installed,
    require => Exec['apt-update-sogo'],
  }
}