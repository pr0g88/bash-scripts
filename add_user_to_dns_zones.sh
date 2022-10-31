#!/bin/bash
# Input new Host to direct and reverse zones

echo -n "Enter direct zone: "
read direct

echo -n "Enter reverse zone(example: 88.168.192): "
read rev

echo -n "Enter host ip address: "
read ipaddr

oct=$(echo $ipaddr | awk -F. -v OFS="." '{print $4}')

echo -n "Enter hostmame: "
read hostn

if [ -e /etc/bind/db.$direct ]
then
        cat >> /etc/bind/db.$direct <<EOF
$hostn  IN      A       $ipaddr
EOF

else
        echo 'There is no such direct zone'
fi


if [ -e /etc/bind/db.$rev ]
then
        cat >> /etc/bind/db.$rev <<EOF
$oct      IN      PTR     $hostn.$direct.
EOF

else
        echo 'There is no such reverse zone'
fi

# Check zones and config
named-checkzone $direct /etc/bind/db.$direct
named-checkzone $rev /etc/bind/db.$rev
named-checkconf

# Reload config
rndc reload

echo "Done!"
