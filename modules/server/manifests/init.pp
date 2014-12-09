class server {

  monit::process { 'monit-sensu-server':
    ensure        => running,
    start_command => '/etc/init.d/sensu-server start',
    stop_command  => '/etc/init.d/sensu-server stop',
    pidfile       => '/var/run/sensu/sensu-server.pid',
  }

  sensu::check { "diskspace":
    command     => '/usr/lib/nagios/plugins/check_disk -w 90% -c 80% -p /',
    interval    => 60,
    subscribers => [
      'common'
    ],
    standalone  => false,
  }

  sensu::check { "ping":
    command     => '/usr/lib/nagios/plugins/check_ping -H google.com -w 25,1% -c 30,1% -p 3 -4',
    interval    => 60,
    subscribers => [
      'common'
    ],
    standalone  => false,
  }

  sensu::check { "load":
    command     => '/usr/lib/nagios/plugins/check_load -w 0.5,0.5,0.5 -c 1.0,1.0,1.0',
    interval    => 60,
    subscribers => [
      'common'
    ],
    standalone  => false,
  }

  sensu::check { "memory":
    command     => '/opt/checks/check-memory-pcnt.sh -w 50 -c 60',
    interval    => 60,
    subscribers => [
      'common'
    ],
    standalone  => false,
  }

  sensu::check { "ntp_time":
    command     => '/usr/lib/nagios/plugins/check_ntp_time -H ntp.ubuntu.com -w 0.5 -c 1',
    interval    => 60,
    subscribers => [
      'common'
    ],
    standalone  => false,
  }

}
