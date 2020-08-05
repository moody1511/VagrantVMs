#!/bin/bash

# Update System
echo "[TASK 1] System Update"
yum upgrade -y -q

# Add Epel Repo
echo "[TASK 2] Install Epel repo"
yum install epel-release -y -q
yum config-manager --set-enabled PowerTools -y -q
yum config-manager --set-enabled PowerTools -y -q
yum upgrade -y -q

# Install tmux
echo "[TASK 3] Install tmux"
yum install tmux -y -q
cat>>/home/vagrant/.tmux.conf<<EOF
bind e set-window-option synchronize-panes
set -g mouse on
bind -t vi-copy y copy-pipe "xclip -sel clip -i"
EOF


# Install Ansible
echo "[TASK 4] Install Ansible"
yum install ansible -y -q

# Install Glance
echo "[TASK 3] Install Glances"
yum install glances -y -q

# Install Git
echo "[TASK 4] Install Git"
yum install git -y -q


# Turn On Firewalld
echo "[TASK 5] Turn On Firewalld"
yum install firewalld -q -y
systemctl start firewalld 
systemctl enable firewalld

# Enable ssh password authentication
echo "[TASK 6] Enable ssh password authentication"
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
systemctl reload sshd

# Set Root password
echo "[TASK 7] Set root password"
echo "vagrant" | passwd --stdin root >/dev/null 2>&1

# Update vagrant user's bashrc file
echo "export TERM=xterm" >> /etc/bashrc

#Install ifconfig
echo "[TASK 8] Install ifconfig"
yum install net-tools -y -q