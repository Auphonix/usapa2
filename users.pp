class user1{
    user { 'becca':
    ensure => 'present',

    # Set her home directory
    home => '/home/becca',

    # Allow the user time to change their password
    password => sha1('password'),
    password_min_age => '1',
    password_max_age => '7',

    # Set UID
    uid => '10017463'

    # Set shell
    shell => '/bin/bash'
    }

    group { 'sysadmin':
    ensure => 'present',
    }

    group { 'cars':
    ensure => 'present',
    }
}
