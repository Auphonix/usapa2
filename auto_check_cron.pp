
# Terminal command
#puppet resource cron puppet-agent ensure=present user=root minute=*/20
#command='/opt/puppetlabs/bin/puppet agent --onetime --no-daemonize --splay --splaylimit 60'

cron { 'puppet-agent':
  ensure  => 'present',
  command => '/opt/puppetlabs/bin/puppet agent --onetime --no-daemonize --splay --splaylimit 60',
  minute  => ['*/20'],
  target  => 'root',
  user    => 'root',
}
