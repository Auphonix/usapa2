class usaptest {
  user { 'becca':
    ensure => present,
    groups => ['rmit'],
  }

  group { 'rmit':
    ensure => present,
  }

  package { 'vim':
    ensure => present,
  }
}
