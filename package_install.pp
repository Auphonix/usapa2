# Enable the extra/optional repo channels for yum
class add_repo {
    exec {'yum-config-manager':
        command => 'yum-config-manager --enable rhui-REGION-rhel-server-extras rhui-REGION-rhel-server-optional',
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
    }
}

# Setup mysql on redhat
class mysql_setup {
    package {'mariadb-server':
        ensure => installed,
        provider => 'yum',
        name => 'mariadb-server',
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
        require => Package["mysql"],

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

    package {'libxfont':
        ensure => installed,
        provider => 'yum',
        name => 'libxfont',
    }

    # =========== VNC PACKAGE ============== #

    package {'vnc-server':
        ensure => installed,
        provider => 'yum',
        name => 'vnc-server',
    }

    # Start the service
    service {'vnc-server':
        ensure => running,
        enable => true, # Ensure it starts on boot
        name => 'vnc-server',
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
        require => Yumrepo['optional_repo'],
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

    package {'cgdb':
        ensure => installed,
        provider => 'yum',
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

    package {'sshfs':
        ensure => installed,
        provider => 'yum',
        name => 'sshfs',
    }
}

class package_install{
    include 'add_repo'
    include 'httpd_setup'
    include 'mysql_setup'
    include 'vnc_setup'
    include 'static_package_setup'
}
