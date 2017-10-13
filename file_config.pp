# Used to fix augeas bug
class fix_augeas{
    # Ensure sed is installed to modify sudoers lens
    package {'sed':
        ensure   => installed,
        provider => 'yum',
        name     => 'sed',
    }

    # Modify the sudoers lens to allow for the updated changes
    # first remove line then replace
    # Not efficient to run everytime but it will work as a tmp solution until augeas updates

    file {'/etc/puppetlabs/code/environments/production/manifests/scripts/sudoers_fixup.sh':
        ensure => 'file',
        path   => '/etc/puppetlabs/code/environments/production/manifests/scripts/sudoers_fixup.sh',
        owner  => 'root',
        group  => 'root',
        mode   => '0777',
        notify => Exec['run_script'],
    }
    exec { 'run_script':
        command => "/bin/bash -c '/etc/puppetlabs/code/environments/production/manifests/scripts/sudoers_fixup.sh'",
    }
}

# Adds root config to httpd
class httpd_root_config{

    # Ensure root directory exists
    file { '/var/www/s3547463':
        ensure  => 'directory',
        recurse => true,
    }

    # Not working...
    # augeas { "httpd_conf":
    #   context => "/files/etc/httpd/conf/httpd.conf",
    #   changes => [
    #     'set DocumentRoot /var/www/s3547463',
    #   ],
    # }

    # Given the same template for http.conf can be used...
    # Move the files
    file {'/etc/httpd/conf/httpd.conf':
        source => '/etc/puppetlabs/code/environments/production/manifests/conf_files/httpd.conf',
    }

}


# Add /usr/local/bin to everyone's directory
class setup_user_bin{
    $user1='becca'
    $user2='fred'
    $user3='wilma'

    # Create directory for all users
    file { "/home/${user1}/usr":
        # Ensure wilma's home directory is created
        ensure => 'directory',
    }
    file { "/home/${user1}/usr/local":
        # Ensure wilma's home directory is created
        ensure => 'directory',
    }
    file { "/home/${user1}/usr/local/bin":
        # Ensure wilma's home directory is created
        ensure => 'directory',
    }

    file { "/home/${user2}/usr":
        # Ensure wilma's home directory is created
        ensure => 'directory',
    }
    file { "/home/${user2}/usr/local":
        # Ensure wilma's home directory is created
        ensure => 'directory',
    }
    file { "/home/${user2}/usr/local/bin":
        # Ensure wilma's home directory is created
        ensure => 'directory',
    }

    file { "/home/${user3}/usr":
        # Ensure wilma's home directory is created
        ensure => 'directory',
    }
    file { "/home/${user3}/usr/local":
        # Ensure wilma's home directory is created
        ensure => 'directory',
    }
    file { "/home/${user3}/usr/local/bin":
        # Ensure wilma's home directory is created
        ensure => 'directory',
    }
}

# Main file config class
class file_config{

    # Configure ssh root
    augeas { 'sshd_config':
      context => '/files/etc/ssh/sshd_config',
      changes => [
        'set PermitRootLogin no',
      ],
    }

    # augeas { "sudobecca":
    #     context => "/files/etc/sudoers",
    #     changes => [
    #       "set Defaults[type=':becca']/type :becca",
    #       "set Defaults[type=':becca']/requiretty/negate ''",
    #       "set spec[user = 'becca']/user becca",
    #       "set spec[user = 'becca']/host_group/host ALL",
    #       "set spec[user = 'becca']/host_group/command ALL",
    #       "set spec[user = 'becca']/host_group/command/runas_user ALL",
    #     ],
    #     lens => Sudoers.ls
    # }

    augeas { 'sudobecca':
      context => '/files/etc/sudoers',
      changes => [
        "set spec[user = 'becca']/user becca",
        "set spec[user = 'becca']/host_group/host ALL",
        "set spec[user = 'becca']/host_group/command ALL",
        "set spec[user = 'becca']/host_group/command/runas_user ALL",
      ],
      lens    => 'Sudoers.lns',
      incl    => '/etc/sudoers',
    }

    # MOUNT TO TITAN
    # exec {'mount_titan':
    #     command => "sshfs s3547463@titan.csit.rmit.edu.au:~/ /home/wilma/titan",
    #     path    => ['/usr/bin', '/usr/sbin', '/bin'],
    # }


    # Configure httpd root directory
    include 'httpd_root_config'
    # Add /usr/local/bin to each users path
    include 'setup_user_bin'
}
