class sogo::frontend {
  package {'nginx':
    ensure => installed,
  }

  file { '/etc/nginx/sites-available/sogo.conf':
    ensure  => file,
    owner   => root,
    group   => root,
    source  => 'puppet:///modules/sogo/sogo.nginx.conf',
    require => Package['nginx'],
  }

  file { '/etc/nginx/sites-enabled/sogo.conf':
    ensure  => 'link',
    target  => '/etc/nginx/sites-available/sogo.conf',
    owner   => root,
    group   => root,
    require => File['/etc/nginx/sites-available/sogo.conf'],
  }

  file { '/etc/nginx/sites-enabled/default':
    ensure  => 'absent',
  }


  service { "nginx":
    ensure  => "running",
    require => [File['/etc/nginx/sites-enabled/sogo.conf'], File['/etc/nginx/sites-enabled/default']],
  }

}