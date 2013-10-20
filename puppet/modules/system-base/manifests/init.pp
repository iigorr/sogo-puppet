class system-base {
  
  exec { "apt-get-init":
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
    command => "apt-get update",
    onlyif => "/bin/sh -c '[ ! -f /var/cache/apt/pkgcache.bin ] || /usr/bin/find /etc/apt/* -cnewer /var/cache/apt/pkgcache.bin | /bin/grep . > /dev/null'",
  }


  $basics = [ "sudo", "vim"]
  package { $basics:
    ensure => "installed",
    require => Exec["apt-get-init"],
  }

  include system-base::users
}