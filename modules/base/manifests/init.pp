class base {

  package { 'nagios-plugins': }
  package { 'tree': }

  host { 'queue-int':
    ip => '172.28.128.29',
  }

  host { 'redis-int':
    ip => '172.28.128.30',
  }

  host { 'api-int':
    ip => '172.28.128.28',
  }

  host { 'dashboard-int':
    ip => '172.28.128.27',
  }

  host { 'server-int':
    ip => '172.28.128.31',
  }

  host { 'graphite-int':
    ip => '172.28.128.36',
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

}
