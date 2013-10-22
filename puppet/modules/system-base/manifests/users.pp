
class system-base::users {

  user { $username:
    ensure     => "present",
    shell      => '/bin/bash',
    home       => "/home/$username",
    managehome => true,
    password_max_age => '99999',
    password_min_age => '0',
    groups     => ["users", "adm", "sudo"],
    require    => [ Package["sudo"]]
  }

  exec { "set-password":
    command => "/bin/echo '$username:$password' | /usr/sbin/chpasswd -e",
    path    => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
    require => User["$username"],
  }
  file { "/home/$username/.ssh":
    ensure  => directory,
    owner   => $username,
    group   => $username,
    mode    => 700,
    require => User[$username]
  }

  file {"/home/$username/.ssh/authorized_keys":
    content => $public_key,
    owner   => $username,
    group   => $username,
    mode    => 600,
    require => File["/home/$username/.ssh"],
  }

}