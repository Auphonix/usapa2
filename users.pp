# Setup becca
class user1{

    # HASH FOR THE DEFAULT PASSWORD 'password'
    $def_hash = '$6$kq22ZJbo$m6uJHRzuBTYJA4tXasjjoml/M9zIco3ht9cNGJ0/x1QYuZQZz0zo2PgUWIxTDzuEh932cLsF.kjup3h1Rs/Gj.'
    # Users name
    $uname = 'becca'


    file { "/home/${uname}":
    # Ensure becca's home directory is created
    ensure => 'directory',
}
file { '/home/becca/.ssh':
# Create ssh directory for wilma
ensure => 'directory',
}
file { '/home/becca/.ssh/authorized_keys':
# Create ssh directory for wilma
ensure => 'present',
owner  => 'becca',
mode   => '0730',
}

user { $uname:
    ensure           => 'present',

    # Set her home directory
    home             => "/home/${uname}",

    # Add to groups
    groups           => ['sysadmin', 'cars'],

    # Allow the user time to change their password
    password         => $def_hash, #enctypts with local encryption
    password_min_age => '1',
    password_max_age => '7',

    # Set UID
    uid              => '10017463',

    # Set shell
    shell            => '/bin/bash',
}

# Ensure host record exists for ssh
file { '/home/becca/.ssh/config':
ensure  => 'present',
content =>
'host titan
HostName titan.csit.rmit.edu.au
User s3547463

host saturn
HostName saturn.csit.rmit.edu.au
User s3547463

host jupiter
HostName jupiter.csit.rmit.edu.au
User s3547463',
}

}

#Setup fred
class user2{

    # HASH FOR THE DEFAULT PASSWORD 'password'
    $def_hash = '$6$kq22ZJbo$m6uJHRzuBTYJA4tXasjjoml/M9zIco3ht9cNGJ0/x1QYuZQZz0zo2PgUWIxTDzuEh932cLsF.kjup3h1Rs/Gj.'
    # Users name
    $uname = 'fred'


    file { "/home/${uname}":
    # Ensure fred's home directory is created
    ensure => 'directory',
}
file { '/home/fred/.ssh':
# Create ssh directory for wilma
ensure => 'directory',
}
file { '/home/fred/.ssh/authorized_keys':
# Create ssh directory for wilma
ensure => 'present',
owner  => 'fred',
mode   => '0730',
}

user { $uname:
    ensure           => 'present',

    # Home dir
    home             => "/home/${uname}",

    # Add to groups
    groups           => ['trucks', 'cars'],

    # Allow the user time to change their password
    password         => $def_hash, #encrypts with local encryption
    password_min_age => '1',
    password_max_age => '7',

    # set UID
    uid              => '10027463',

    # Set shell
    shell            => '/bin/csh',
}

# Ensure host record exists for ssh
file { '/home/fred/.ssh/config':
ensure  => 'present',
content =>
'host titan
HostName titan.csit.rmit.edu.au
User s3547463

host saturn
HostName saturn.csit.rmit.edu.au
User s3547463

host jupiter
HostName jupiter.csit.rmit.edu.au
User s3547463',
}
}

# Create wilma
class user3{
    # HASH FOR THE DEFAULT PASSWORD 'password'
    $def_hash = '$6$kq22ZJbo$m6uJHRzuBTYJA4tXasjjoml/M9zIco3ht9cNGJ0/x1QYuZQZz0zo2PgUWIxTDzuEh932cLsF.kjup3h1Rs/Gj.'
    # Users name
    $uname = 'wilma'

    file { "/home/${uname}":
    # Ensure wilma's home directory is created
    ensure => 'directory',
}

file { "/home/${uname}/.ssh":
# Create ssh directory for wilma
ensure => 'directory',
}
file { "/home/${uname}/.ssh/authorized_keys":
# Create ssh directory for wilma
ensure => 'present',
owner  => 'wilma',
mode   => '0730',
}

user { $uname:
    ensure           => 'present',

    # Home dir
    home             => "/home/${uname}",

    # Add to groups
    groups           => ['trucks', 'cars', 'ambulances'],

    # Allow the user time to change their password
    password         => $def_hash, #encrypts with local encryption
    password_min_age => '1',
    password_max_age => '7',

    # set UID
    uid              => '10037463',
}

# ssh key
sshkey { 'wilma_ssh':
ensure       => 'present',
name         => 'wilma_key',
type         => 'ssh-rsa',
host_aliases => 's3547463@titan.csit.rmit.edu.au',
target       => '/home/wilma/.ssh/known_hosts',
key          => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDaTbDeLJPw2eOcZlX4rubF2X8Z9DzuIHfZ2KF0WXSkTV8IDk
bouI6XavO1Ca12ZcJSRq/ebFFVKqpeMqX5SiFt2zpZu8660t4Wfn1M+P4SS7+aaW7L2gFTKnXr
c5MlrBgsdKLc1wqjN9MGeCBOaJmtPZkd7Z2I1wtw9Bs5l6DZKrooXAqgWDa3gWVL76vQ4rewhU
DDSJxBRVTKFQ296cLBQa/lg+bzaPBIVHxZH841fmcDNUSZvnWMiIa4yV9V5/S+lKJYQOj2KdhD
A9qzA6nslAHkghDE2gYflrzzmwpOtxUnPymniAH7OjGbJNmVWmO/Y1uLJZfBGgfIkqttIgn',
}


# Ensure host record exists for ssh
file { '/home/wilma/.ssh/config':
ensure  => 'present',
content =>
'host titan
HostName titan.csit.rmit.edu.au
User s3547463

host saturn
HostName saturn.csit.rmit.edu.au
User s3547463

host jupiter
HostName jupiter.csit.rmit.edu.au
User s3547463',
}
}


# Main Class to run user setup
class user_setup{

    $timestamp = generate('/bin/date', '+%Y%d%m_%H:%M:%S')
    notify { 'agent_notice':
    message => "Agent run starting at ${timestamp}"
}

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
group { 'ambulances':
ensure => 'present',
}

# ------- SETUP PACKAGES --------- #
package { 'csh': # ensure csh shell is installed
ensure   => 'present',
name     => 'csh',
provider => 'yum',
}
package { 'bash': # ensure bash shell is installed
ensure   => 'present',
name     => 'bash',
provider => 'yum',
}


# Run all users
include 'user1'
include 'user2'
include 'user3'
}
