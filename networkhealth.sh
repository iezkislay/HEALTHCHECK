#!/bin/bash

read -p "Enter name for customized bridge network: " custom
docker network create -d bridge $custom
read -p "Enter 5 names for container $x: " name1 name2 name3 name4 name5
docker run -dt --name $name1 --network $custom busybox sh
docker run -dt --name $name2 --network $custom busybox sh
docker run -dt --name $name3 --network $custom busybox sh
docker run -dt --name $name4 --network $custom busybox sh
docker run -dt --name $name5 --network $custom busybox sh
read -p "Enter the last container name to link with all the containers: " last
docker run -dt --name $last --link $name1:$name2 --link $name2:$name3 --link $name3:$name4 --link $name4:$name5 --link $name5:$name6 --link $name6:$name1 --network $custom ubuntu
x=8081
while [ $x -le 8087 ]
do
	sed -i 's/$x/`expr $x + 1`/g' Dockerfile
	x=`expr $x + 1`
done
