class queue {

  rabbitmq_user { 'sensu':
    admin    => true,
    password => 'password',
  }

  ->

  rabbitmq_vhost { 'sensu':
    ensure => present,
  }

  ->

  rabbitmq_user_permissions { 'sensu@sensu':
    configure_permission => '.*',
    read_permission      => '.*',
    write_permission     => '.*',
  }

}
