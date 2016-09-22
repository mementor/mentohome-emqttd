#!/bin/sh

docker-compose run emqttd vi /emqttd/etc/emqttd.conf

docker-compose run emqttd vi /emqttd/etc/modules/passwd.conf