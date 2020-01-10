#!/bin/bash

#edit the port number in Dockerfile
sed -i 's/port_number/'$1'/' ./Dockerfile

#start building image from Dockerfile
docker build -t $2 .

#run container from built image
docker container run -d -it --name $3 -p $1:$1 $2
docker container start $3

#return Dockerfile into first state
sed -i 's/'$1'/port_number/' ./Dockerfile

