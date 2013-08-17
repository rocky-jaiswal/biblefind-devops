class patience::nginx {
  
  include stdlib
  include apt

  apt::ppa { "ppa:nginx/stable": 
    before  => Package["nginx"],
  }

  package { "python-software-properties": 
    ensure => latest 
  }

  package { "nginx": 
    ensure => latest,
    require => Package["python-software-properties"],
    before => File["logfile1", "logfile2"]
  }

  service { "nginx": 
    ensure => running,
    require => Package["nginx"]
  }

  file { "logfile1":
    path    => "/var/log/nginx/biblefind.access.log",
    ensure  => present,
    mode    => 0644,
  }

  file { "logfile2":
    path    => "/var/log/nginx/api.access.log",
    ensure  => present,
    mode    => 0644,
  }

  file { "unwanted-default":
    path    => "/etc/nginx/sites-enabled/default",
    ensure  => absent,
    before => File["patience-avaliable"]
  }

  file { "biblefind-avaliable":
    path    => "/etc/nginx/sites-available/biblefind",
    ensure  => present,
    mode    => 0644,
    source  => "puppet:///modules/patience/static/biblefind",
    require => File["logfile1", "unwanted-default"],
    notify  => Service["nginx"],
  }

  file { "biblefind-enabled":
    path    => "/etc/nginx/sites-enabled/biblefind",
    ensure  => link,
    mode    => 0644,
    target  => "/etc/nginx/sites-available/biblefind",
    require => File["biblefind-avaliable"],
  }

  file { "api-avaliable":
    path    => "/etc/nginx/sites-available/api",
    ensure  => present,
    mode    => 0644,
    source  => "puppet:///modules/patience/static/api",
    require => File["logfile2", "unwanted-default"],
    notify  => Service["nginx"],
  }

  file { "api-enabled":
    path    => "/etc/nginx/sites-enabled/api",
    ensure  => link,
    mode    => 0644,
    target  => "/etc/nginx/sites-available/api",
    require => File["api-avaliable"],
  }

}