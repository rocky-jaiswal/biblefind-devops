class biblefind::packages {
  
  include stdlib
  include apt
  include mongodb

  class mongodb {
    init => 'sysv',
  }

  package { "openjdk-7-jdk": 
    ensure => latest,
  }

}