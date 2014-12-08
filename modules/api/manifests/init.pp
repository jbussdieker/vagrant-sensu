class api {

  monit::process { 'monit-sensu-api':
    ensure        => running,
    start_command => '/etc/init.d/sensu-api start',
    stop_command  => '/etc/init.d/sensu-api stop',
    pidfile       => '/var/run/sensu/sensu-api.pid',
  }

}
