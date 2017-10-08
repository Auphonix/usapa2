class user1{

    # HASH FOR THE DEFAULT PASSWORD 'password'
    $def_hash = '$6$kq22ZJbo$m6uJHRzuBTYJA4tXasjjoml/M9zIco3ht9cNGJ0/x1QYuZQZz0zo2PgUWIxTDzuEh932cLsF.kjup3h1Rs/Gj.'
    # Users name
    $uname = 'becca'

    file { "/home/$uname":
    # Ensure becca's home directory is created
    ensure => 'directory',
    }

    user { "$uname":
    ensure => 'present',

    # Set her home directory
    home => "/home/$uname",

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

}

class user2{

    # HASH FOR THE DEFAULT PASSWORD 'password'
    $def_hash = '$6$kq22ZJbo$m6uJHRzuBTYJA4tXasjjoml/M9zIco3ht9cNGJ0/x1QYuZQZz0zo2PgUWIxTDzuEh932cLsF.kjup3h1Rs/Gj.'
    # Users name
    $uname = 'fred'

    file { "/home/$uname":
    # Ensure fred's home directory is created
    ensure => 'directory',
    }

    user { "$uname":
    ensure => 'present',

    # Home dir
    home => "/home/$uname",

    # Add to groups
    groups => ['trucks', 'cars'],

    # Allow the user time to change their password
    password => $def_hash, #encrypts with local encryption
    password_min_age => '1',
    password_max_age => '7',

    # set UID
    uid => '10027463',

    # Set shell
    shell => 'csh',
    }
}


# Main Class to run user setup
class userSetup{

    # ------- SETUP GROUPS --------- #
    group { 'sysadmin':
    ensure => 'present',
    }

    group { 'cars':
    ensure => 'present',
    }

    group { 'trucks':
    ensure => 'present',
    }

    # ------- SETUP PACKAGES --------- #
    package { 'csh': # ensure csh shell is installed
    ensure => 'present',
    name => 'csh',
    }
    package { 'bash': # ensure bash shell is installed
    ensure => 'present',
    name => 'bash',
    }


    # Run all users
    include 'user1'
    include 'user2'
}
