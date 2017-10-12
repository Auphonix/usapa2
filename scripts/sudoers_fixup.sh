#!/bin/bash
sed -i -e '311d' /opt/puppetlabs/puppet/share/augeas/lenses/dist/sudoers.aug

sed -i '311i \\t\t\t | "umask_override" | "use_pty" | "match_group_by_gid"' /opt/puppetlabs/puppet/share/augeas/lenses/dist/sudoers.aug
