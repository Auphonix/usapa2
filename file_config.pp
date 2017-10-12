class file_config{
    augeas { "sshd_config":
      context => "/etc/ssh/sshd_config",
      changes => [
        "set PermitRootLogin no",
      ],
    }
}
