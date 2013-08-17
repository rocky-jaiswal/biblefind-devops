class biblefind::packages {
  
  include stdlib
  include apt
  include mongodb

  class mongodb

  package { "openjdk-7-jdk": 
    ensure => latest,
  }

}