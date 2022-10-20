#!/bin/bash

# Resolv

echo "Configure resolv.conf ..."
echo -n "Enter nameserver: "
read ns

echo -n "Enter the full domain name: "
read domain

echo "nameserver $ns" > test.txt
echo "search $domain" >> test.txt

# Network adapter

echo "Configure network ..."
echo -n "Enter ip address: "
read addr

echo -n "Enter netmask: "
read nmask

echo -n "Enter gateway: "
read gate

int=`ls /sys/class/net/ | xargs | cut -d ' ' -f 1` 

echo "
source /etc/network/interfaces.d/*

auto lo
iface lo inet loopback

auto $int
iface $int inet static
        address $addr
        netmask $nmask
        gateway $gate

" > net.txt

systemctl restart networking.service

echo "*** CONFIGURATION CHECK ... ###"
echo "cat /etc/resolv.conf"
cat /etc/resolv.conf
echo "CHECK NETWORK ..."
ip a | grep $int
ping -c 4 $gate
