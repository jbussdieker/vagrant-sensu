class graphite {

  package { ['graphite-web', 'graphite-carbon']:
    ensure => installed,
  }

  package { ['apache2', 'libapache2-mod-wsgi']:
    ensure => installed,
  }

  file { '/etc/default/graphite-carbon':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => "CARBON_CACHE_ENABLED=true\n",
    notify  => Service['carbon-cache'],
  }

  file { '/etc/apache2/sites-available/graphite.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => '/usr/share/graphite-web/apache2-graphite.conf',
    require => [
      Package['graphite-web'],
      Package['apache2'],
      Package['libapache2-mod-wsgi'],
    ],
    notify  => Service['apache2'],
  }

  file { '/etc/apache2/sites-enabled/000-default.conf':
    ensure  => absent,
    require => Package['apache2'],
    notify  => Service['apache2'],
  }


  file { '/var/lib/graphite/graphite.db':
    ensure  => file,
    owner   => 'root',
    group   => '_graphite',
    mode    => '0664',
    source  => 'puppet:///modules/graphite/graphite.db',
    require => [
      Package['graphite-web'],
      Package['graphite-carbon'],
    ],
    notify  => Service['apache2'],
  }

  exec { 'enable_graphite_site':
    command => '/usr/sbin/a2ensite graphite',
    creates => '/etc/apache2/sites-enabled/graphite.conf',
    require => File['/etc/apache2/sites-available/graphite.conf'],
    notify  => Service['apache2'],
  }

  service { 'carbon-cache':
    ensure  => running,
    require => Package['graphite-carbon'],
  }

  service { 'apache2':
    ensure  => running,
    require => Package['apache2'],
  }

}
