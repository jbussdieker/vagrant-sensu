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

  file { '/opt/checks':
    ensure  => directory,
    recurse => true,
    purge   => true,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    source  => 'puppet:///modules/base',
  }

  sensu::check { "diskspace":
    command     => '/usr/lib/nagios/plugins/check_disk -w 95% -c 90% -p /',
    interval    => 1,
    subscribers => [
      'common'
    ],
  }

  sensu::check { "load":
    command     => '/usr/lib/nagios/plugins/check_load -w 0.05,0.10,0.20 -c 0.1,0.2,0.4',
    interval    => 1,
    subscribers => [
      'common'
    ],
  }

  sensu::check { "memory":
    command     => '/opt/checks/check-memory-pcnt.sh -w 35 -c 40',
    interval    => 1,
    subscribers => [
      'common'
    ],
  }

  sensu::check { "ntp_time":
    command     => '/usr/lib/nagios/plugins/check_ntp_time -H ntp.ubuntu.com -w 0.5 -c 1',
    interval    => 1,
    subscribers => [
      'common'
    ],
  }

}
