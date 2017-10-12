class httpd_root_setup{

    # Ensure root directory exists
    file { "/var/www/s3547463":
        ensure => 'directory',
    }

    augeas { "httpd_conf":
      context => "/files/etc/httpd/conf/httpd_conf",
      changes => [
        "set DocumentRoot /var/www/s3547463",
      ],
    }

}

class file_config{
    # Configure ssh root
    augeas { "sshd_config":
      context => "/files/etc/ssh/sshd_config",
      changes => [
        "set PermitRootLogin no",
      ],
    }

    # Configure httpd root directory
    httpd_root_setup
}