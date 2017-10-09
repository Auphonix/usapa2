package {'openssh':
    ensure => installed,
    provider => 'yum',
    name => 'openssh',
}

package {'gcc':
    ensure => installed,
    provider => 'yum',
    name => 'gcc',
}
