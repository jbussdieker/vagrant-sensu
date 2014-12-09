class base::hosts {

  file { '/vagrant/.hosts':
    ensure => file,
  }
->
  file { '/etc/hosts':
    ensure => link,
    target => '/vagrant/.hosts',
  }
->
  host { $::hostname:
    ip => $::ipaddress_eth1,
  }

}
