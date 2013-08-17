class biblefind::packages {
  
  include stdlib
  include apt

  package { "openjdk-7-jdk": 
    ensure => latest,
  }

}