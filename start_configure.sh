#!/bin/bash

# Resolv

echo "Configure resolv.conf ..."
echo -n "Enter nameserver: "
read ns

echo -n "Enter the full domain name: "
read domain

cat > /etc/resolv.conf <<EOF
nameserver $ns
search $domain

EOF

# Network adapter

echo "Configure network ..."
echo -n "Enter ip address: "
read addr

echo -n "Enter netmask: "
read nmask

echo -n "Enter gateway: "
read gate

int=`ls /sys/class/net/ | xargs | cut -d ' ' -f 1` 

cat > /etc/network/interfaces <<EOF
source /etc/network/interfaces.d/*

auto lo
iface lo inet loopback

auto $int
iface $int inet static
        address $addr
        netmask $nmask
        gateway $gate
EOF

systemctl restart networking.service

# Other
#timedatectl set-timezone Europe/Moscow
#apt install -y vim

echo "*** CONFIGURATION CHECK ... ###"
echo "cat /etc/resolv.conf"
cat /etc/resolv.conf
echo "CHECK NETWORK ..."
ip a | grep $int
ping -c 4 $gate
