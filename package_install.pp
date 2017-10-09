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

package {'emacs':
    ensure => installed,
    provider => 'yum',
    name => 'emacs',
}
