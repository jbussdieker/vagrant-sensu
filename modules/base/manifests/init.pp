class base {

  package { 'nagios-plugins': }

  host { 'queue-int':
    ip => '172.28.128.22',
  }

  host { 'redis-int':
    ip => '172.28.128.23',
  }

  host { 'api-int':
    ip => '172.28.128.24',
  }

  host { 'dashboard-int':
    ip => '172.28.128.25',
  }

  host { 'server-int':
    ip => '172.28.128.26',
  }

  file { '/var/tmp/check-memory-pcnt.sh':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    source => 'puppet:///modules/base/check-memory-pcnt.sh',
  }

  sensu::check { "diskspace":
    command     => '/usr/lib/nagios/plugins/check_disk -w 95% -c 90% -p /',
    subscribers => [
      'common'
    ],
  }

  sensu::check { "load":
    command  => '/usr/lib/nagios/plugins/check_load -w 0.05,0.05,0.05 -c 0.1,0.1,0.1',
    subscribers => [
      'common'
    ],
  }

  sensu::check { "memory":
    command  => '/var/tmp/check-memory-pcnt.sh -w 10 -c 20',
    subscribers => [
      'common'
    ],
  }

}
