#!/bin/bash
echo "========================================"
echo "MAKE SURE YOU RAN AS ROOT!"
echo "sudo ./salt_install.sh <master/minion>"
echo "========================================"
apt-get update
apt-get install wget -y
wget -O - https://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -
echo "deb http://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest xenial main" > /etc/apt/sources.list.d/saltstack.list
apt-get update
if [ "$1" == "master" ]; then
	echo "Installing salt-master.."
	sudo apt-get install salt-master -y
	sudo salt-key -F master
	echo "sudo salt-key -L to list"
	echo "sudo salt-key -A to accept all"
	echo "===================================================="
	echo "RUN CMDS: sudo salt 'target/regex' cmd.run 'whoami'"
	echo "===================================================="
	sudo mkdir /srv/salt
	sudo mkdir /srv/salt/adduser
	sudo curl https://pastebin.com/raw/rrsF3z42 > /srv/salt/adduser/init.sls
	sudo curl https://pastebin.com/raw/D3FYN31w > /srv/salt/top.sls
	echo "Added gretchen:password across all machines."
	echo "Run (salt '*' state.apply) to reapply states globally."
	
elif [ "$1" == "minion" ]; then
	echo "Installing salt-minion.."
	sudo apt-get install salt-minion -y
	echo "============================"
	echo "       MANUAL SETUP         "
	echo "============================"
	echo "1. Configure /etc/salt/minion with master: <mIP>"
	echo "2. Configure /etc/salt/minion with master_finger: '<fingerprint'"
	echo "3. Restart minion! (sudo systemctl restart salt-minion)"
else
	echo "Bad arguments! Usuage: sudo ./salt_install.sh <master/minion>"
fi
