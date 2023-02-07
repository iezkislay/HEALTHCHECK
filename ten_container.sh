#!/bin/sh
x=1
while [ $x -le 10 ]
do
        read -p "Enter name for container $x: " cont
        docker run --name $cont -dt python
        docker inspect $cont
        read -p "Enter IP for conatiner $x: " ip
        echo "FROM busybox" >> Dockerfile
        echo "HEALTHCHECK --interval=5s CMD ping -c 5 $ip" >> Dockerfile
	read -p "Enter a name for HEALTHCHECK image: " health_ck
        docker build -t $health_ck .
        truncate -s 0 Dockerfile
        read -p "Enter name for HEALTHCHECK container: " health
        docker run --name $health -dt $health_ck
        x=`expr $x + 1`
done
