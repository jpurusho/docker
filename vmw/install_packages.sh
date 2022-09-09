#!/bin/bash

# Bash "strict mode", to help catch problems and bugs in the shell
# script. Every bash script you write should include this. See
# http://redsymbol.net/articles/unofficial-bash-strict-mode/ for
# details.
set -euo pipefail

test -f requirements.txt && pip3 install -r $_

# Clone pyvmomi from github
git clone https://github.com/vmware/pyvmomi.git
git clone https://github.com/vmware/pyvmomi-community-samples.git

cd /app/pyvmomi && sudo python3 setup.py install
cd /app/pyvmomi-community-samples && sudo python3 setup.py install

# Cleanup git clones
#sudo rm -rf /app/pyvmomi /app/pyvmomi-community-samples
