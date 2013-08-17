class biblefind::production {

  include biblefind::nginx
  include biblefind::packages
  include ufw

  Exec {
    path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
  }

  ufw::allow { "allow-ssh-from-all":
    port => 22,
  }

  ufw::allow { "allow-http-from-all":
    port => 80,
  }

  user { "deploy":
    comment => "Deploy User",
    home    => "/home/deploy",
    ensure  => present,
    gid     => "www-data",
    shell   => "/bin/bash",
    managehome   => true,
  }

  file { "home":
    path    => "/home/deploy",
    ensure  =>  directory,
    owner   => "deploy",
    group   => "www-data",
    require => User["deploy"],
  }

  file { "biblefind":
    path    => "/home/deploy/biblefind",
    ensure  =>  directory,
    owner   => "deploy",
    group   => "www-data",
    recurse => true,
    require => File["home"],
  }

}
