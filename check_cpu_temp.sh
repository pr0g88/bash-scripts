#!/bin/bash

# Check the CPU temperature use Sensors

host=$(hostname)

sens_arr=( $(printf '%d°\n' $(sensors | grep 'temp1:' | awk '{ print $2 }') 2>/dev/null | sed 's/.$//') )

for sens in "${sens_arr[@]}"

do

if [ $sens -gt 50 ] # If the CPU temperature is higher then the value
then
  echo The CPU temperature is $sens | mail -s "High temperature of CPU at the $host" admin@example.com 
fi

done
