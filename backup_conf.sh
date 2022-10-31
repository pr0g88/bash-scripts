#!/bin/bash

mkdir backup

dir=backup/
int=/etc/network/interfaces
br0=/etc/network/inerfaces.d/br0
vsftp=/etc/vsftpd.conf

if [ -e $br0 ]
then
	cp $br0 $dir
else
	cp $int $dir
fi

if [ -e $vsftp ]
then
	cp $vsftp $dir
fi

sudo cp /etc/hosts $dir
sudo cp /etc/hostname $dir
sudo cp /etc/apt/sources.list $dir
sudo cp /etc/resolv.conf $dir

echo "Done!"
