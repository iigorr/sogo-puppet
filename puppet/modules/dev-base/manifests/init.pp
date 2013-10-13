
class dev-base {

  $basics = [ "screen", "strace", "curl", "wget", "telnet", "emacs" ]
  package { $basics:
    ensure => "installed",
  }

  package { "git-core":
    ensure => installed,
  }


  include dev-base::ruby
}