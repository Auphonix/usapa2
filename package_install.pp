package {'openssh':
    ensure => installed,
    provider => 'yum',
    name => 'openssh',
}

package {'httpd':
    ensure => installed,
    provider => 'yum',
    name => 'httpd',
}

package {'mysql':
    ensure => installed,
    provider => 'yum',
    name => 'mysql',
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
