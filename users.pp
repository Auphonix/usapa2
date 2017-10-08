class users{
    user { 'becca'
    ensure => 'present',
    home => '/home/becca',

    # Allow the user time to change their password
    password => sha1('password'),
    password_min_age => '1',
    password_max_age => '7',
    }
}
