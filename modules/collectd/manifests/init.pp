class collectd(
  $graphite_host = "graphite"
) {

  package { 'collectd':
    ensure => present,
  }

  file { '/etc/collectd/collectd.conf.d/graphite.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('collectd/graphite.conf'),
    require => Package['collectd'],
    notify  => Service['collectd'],
  }

  service { 'collectd':
    ensure  => running,
    require => Package['collectd'],
  }

}
