class user1{

    file { '/home/becca':
    # Ensure becca's home directory is created
    ensure => 'directory',
    }

    user { 'becca':
    ensure => 'present',

    # Set her home directory
    home => '/home/becca',

    # Add to groups
    groups => ['sysadmin', 'cars'],

    # Allow the user time to change their password
    password => sha1('password'), #enctypts with local encryption
    password_min_age => '1',
    password_max_age => '7',

    # Set UID
    uid => '10017463',

    # Set shell
    shell => '/bin/bash',
    }

    group { 'sysadmin':
    ensure => 'present',
    }

    group { 'cars':
    ensure => 'present',
    }
}
