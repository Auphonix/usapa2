# Enable the extra/optional repo channels for yum
class add_repo {
    exec {'yum-config-manager':
        command => 'yum-config-manager --enable rhui-REGION-rhel-server-extras rhui-REGION-rhel-server-optional rhui-REGION-rhel-server-updates',
        path    => '/usr/local/bin/:/bin/',
    }
}

class httpd_setup{

    # Install a package
    package {'httpd':
        ensure => installed,
        provider => 'yum',
        name => 'httpd',
    }

    # Start the service
    service {'httpd':
        ensure => running,
        enable => true, # Ensure it starts on boot
        name => 'httpd',
        subscribe => File['/var/www/s3547463'],
    }
}

# Setup mysql on redhat
class mysql_setup {

    package {'mysql57-community-release-el7-9.noarch':
    ensure => installed,
    provider => rpm,
    source => 'https://dev.mysql.com/get/mysql57-community-release-el7-9.noarch.rpm',
    }

    package {'mysql-server':
        ensure => installed,
        provider => 'yum',
        name => 'mysql-server',
    }

    package {'mysql':
        ensure => installed,
        provider => 'yum',
        name => 'mysql',
    }

    # Start the service
    service {'mysqld':
        ensure => running,
        enable => true, # Ensure it starts on boot
        require => Package["mysql-server"],

    }
}

class vnc_setup {

    # ============ VNC REQUIRED PACKAGES ========== #
    package {'pixman':
        ensure => installed,
        provider => 'yum',
        name => 'pixman',
    }

    package {'pixman-devel':
        ensure => installed,
        provider => 'yum',
        name => 'pixman-devel',
    }

    # =========== VNC PACKAGE ============== #

    package {'vnc-server':
        ensure => installed,
        provider => 'yum',
        name => 'vnc-server',
    }

    package {'xorg-x11-fonts-Type1':
        ensure => installed,
        provider => 'yum',
        name => 'xorg-x11-fonts-Type1',
    }
}

class sshfs_setup {
    package {'fuse':
        ensure => installed,
        provider => 'yum',
        name => 'fuse',
    }

    package {'fuse-devel':
        ensure => installed,
        provider => 'yum',
        name => 'fuse-devel',
    }

    package {'fuse-sshfs':
        ensure => installed,
        source => 'ftp://195.220.108.108/linux/fedora/linux/releases/26/Everything/x86_64/os/Packages/f/fuse-sshfs-2.8-2.fc26.x86_64.rpm',
        provider => 'rpm',
        name => 'fuse-sshfs',
    }
}

class static_package_setup{
    package {'openssh':
        ensure => installed,
        provider => 'yum',
        name => 'openssh',
    }

    package {'tmux':
        ensure => installed,
        provider => 'yum',
        name => 'tmux',
    }

    package {'lynx':
        ensure => installed,
        provider => 'yum',
        name => 'lynx',
    }

    package {'gcc':
        ensure => installed,
        provider => 'yum',
        name => 'gcc',
    }

    package {'gdb':
        ensure => installed,
        provider => 'yum',
        name => 'gdb',
    }

    package {'cgdb-0.6.8-1.el7.x86_64':
        ensure => installed,
        source => 'http://dl.fedoraproject.org/pub/epel/7/x86_64/c/cgdb-0.6.8-1.el7.x86_64.rpm',
        provider => 'rpm',
        name => 'cgdb',
    }

    package {'vim':
        ensure => installed,
        provider => 'yum',
        name => 'vim',
    }

    package {'emacs':
        ensure => installed,
        provider => 'yum',
        name => 'emacs',
    }
}

class package_install{
    include 'add_repo'
    include 'httpd_setup'
    include 'mysql_setup'
    include 'vnc_setup'
    include 'sshfs_setup'
    include 'static_package_setup'
}
