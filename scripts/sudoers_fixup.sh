#!/bin/bash
sed -i -e '311d' /opt/puppetlabs/puppet/share/augeas/lenses/dist/sudoers.aug

sed -i $content /opt/puppetlabs/puppet/share/augeas/lenses/dist/sudoers.aug
