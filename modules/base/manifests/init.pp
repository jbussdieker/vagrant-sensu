class base {

  include hosts

  package { 'nagios-plugins': }

  file { '/opt/checks':
    ensure  => directory,
    recurse => true,
    purge   => true,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    source  => 'puppet:///modules/base',
  }

  monit::process { 'monit-sensu-client':
    ensure        => running,
    start_command => '/etc/init.d/sensu-client start',
    stop_command  => '/etc/init.d/sensu-client stop',
    pidfile       => '/var/run/sensu/sensu-client.pid',
  }

}
