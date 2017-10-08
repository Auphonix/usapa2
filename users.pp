class user1{

    # HASH FOR THE DEFAULT PASSWORD 'password'
    $def_hash = '$6$kq22ZJbo$m6uJHRzuBTYJA4tXasjjoml/M9zIco3ht9cNGJ0/x1QYuZQZz0zo2PgUWIxTDzuEh932cLsF.kjup3h1Rs/Gj.'

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
    password => $def_hash, #enctypts with local encryption
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
