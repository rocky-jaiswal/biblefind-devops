class biblefind::packages {
  
  include stdlib
  include apt

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