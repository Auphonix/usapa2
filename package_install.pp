package {'openssh':
    ensure => installed,
    provider => 'yum',
    name => 'openssh',
}
