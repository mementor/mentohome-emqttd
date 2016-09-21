#!/bin/sh

/emqttd/bin/emqttd start
sleep 5
while [ x$(/emqttd/bin/emqttd_ctl status |grep "is running" |awk '{print $1}') != x ]
do
echo "running..."
sleep 10
done