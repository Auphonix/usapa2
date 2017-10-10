class add_repo {
    yumrepo {'optional_repo':
        enabled => 1,
        desc => "Includes optional packages",
        baseurl => "rhui-REGION-rhel-server-optional/7Server/x86_64",
        gpgcheck => 0,
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
        require => yumrepo['optional_repo'],
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
