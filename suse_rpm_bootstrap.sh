#!/usr/bin/env bash

#Send all output of userdata script to /var/log/user-data.log and the console
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

# Install dependencies. SLES 15 has iproute-tc2 installed by default
sudo zypper install -y iproute-tc libcap-progs curl

# Add the Gremlin repo
curl https://rpm.gremlin.com/gremlin.repo -o /tmp/gremlin.repo && sudo zypper addrepo /tmp/gremlin.repo

# Install Gremlin and dependencies
sudo zypper refresh && sudo zypper install gremlin gremlind