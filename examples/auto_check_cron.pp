cron { 'puppet-agent':
  ensure  => 'present',
  command => '/opt/puppetlabs/bin/puppet agent --onetime --no-daemonize --splay --splaylimit 60',
  minute  => ['*/20'],
  target  => 'root',
  user    => 'root',
}
