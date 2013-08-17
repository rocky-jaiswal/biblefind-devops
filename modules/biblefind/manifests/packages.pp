class biblefind::packages {
  
  include stdlib
  include apt
  include mongodb

  class mongodb {
      enable_10gen => true,
  }

  apt::ppa { "ppa:chris-lea/node.js": 
    before  => Package["nodejs"],
  }

  package { "nodejs": 
    ensure => latest,
    require => Package["python-software-properties"]
  }

  package { "openjdk-7-jdk": 
    ensure => latest,
  }

}