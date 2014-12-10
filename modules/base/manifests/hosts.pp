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
  host { 'localhost':
    ip => '127.0.0.1',
  }
->
  host { $::hostname:
    ip => $::ipaddress_eth1,
  }

}
