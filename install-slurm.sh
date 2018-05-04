#!/bin/bash
apt-get install -y libmunge-dev libmunge2 munge

useradd munge

rm /etc/munge/munge.key

dd if=/dev/urandom bs=1 count=1024 > /etc/munge/munge.key

chown munge:munge /etc/munge/munge.key

chmod 400 /etc/munge/munge.key

sed -i '/munge/c\munge:x:5566:5566::/var/run/munge;/sbin/nologin'  /etc/passwd

/etc/init.d/munge start

munge -n | unmunge

# Copy munge.key file from server to each node from cluster

/etc/init.d/slurmd start

/etc/init.d/slurmctld start


