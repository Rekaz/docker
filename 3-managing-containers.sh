# list the containers 
docker container ls -a

# create a nginx container
docker container create nginx

docker container ls -a # verify the container's present or not

# create a container with a proper name "Web01"
docker container create --name web01 nginx 
docker container ls   #lists the container that are running
docker container ls -a # to see that new container with image nginx got the name as web01

# to start the container (it will start running)
docker container start web01

docker container ls # list the containers that are running

# create a container using run, (create + start = run)
docker container run --name server01 centos:7 

docker container ls -a # list running containers as well as exited containers

# create a container using run and adding -i -t for interactive terminal
docker container run --name server02 -i -t centos:7 
# the below two commands ran inside the container that we started above in the interactive mode
# ps 
# exit

# create a container and it starts in detached mode (it runs in background)
docker container run --name server03 -dit centos:7 

docker container ls -a # to list all running and exited containers

# to attach with the running container
docker container attach server03

ps

# to exit the container, use ctrl + pq

#since we have exited the container after typing exit, we need to run it again
docker container run --name server03 -dit centos:7
#to run a command inside a container without "attach"ing to it
docker container exec server03 cat /etc/resolve.conf

# rename the existing container
docker container rename server03 server003

docker container ls -a # list all running and exited containers

# pause the exisitng running container
docker container pause server003

docker container ls -a # list all running and exited containers

# to unpause thecontainer
docker container unpause server003

docker container ls -a # list all running and exited containers

# to stop the container
docker container stop server003

docker container ls -a # list all running and exited containers

#to start the earlier stopped container
docker container start server003

docker container ls -a # list all running and exited containers

docker container start server02

docker container ls -a # list all running and exited containers

# to kill the container
docker container kill server003

docker container ls -a # list all running and exited containers

# to restart/start the container (both are same, start and restart)
docker container restart server003

docker container ls -a # list all running and exited containers

#create a container and expose it on a custom port to the container
docker container run --name web02 -dit -p 8080:80 nginx # container port is 80 and it is exposed to port 8080 of host

docker container ls -a # list all running and exited containers

# create a container and expose it to random port (host port default dynamic range is 32768-60999)
docker container run  --name web03 -dit -P nginx

docker container ls -a # list all running and exited containers

# inspect a container
docker container inspect web02 | grep -e "HostPort" -e "IPAddress" | uniq

curl 172.17.0.5 # to access the webserver by using container IP
#note: we can access webserver by using host IP and the port on which the webserver is hosted. to get port IP, run the command, ip a s eth0

# inspect web03 container
docker container inspect web03 | grep -e "HostPort" -e "IPAddress" | uniq

curl 172.17.0.6 # to access the webserver by using container IP


# docker cp command
#first, create a file
cat > index.html << EOF
Welcome to Docker Training!!!
EOF
#second, use cp command
docker container cp index.html web02:/usr/share/nginx/html/index.html
#third, try to access the webserver using the container IP
curl 172.17.0.5


#update memory configuration of container
#first, inspect the memory assigned to the container
docker container inspect web02 | grep Memory | head -1
#second, run the below command to update the memory 
docker container update --memory 200M --memory-swap 200M web02
#note: swap is used only if memory is also set. we use "swap memory", from disk, when entire "memory" from RAM is already getting used.
#third, inspect again
docker container inspect web02 | grep Memory | head -1


# to check the size of container
docker container ls -sa

#to see top running processes in a container
docker container top server003

# to verify stats of running container
docker container stats --no-stream

#to verify logs of a container
docker container logs server003 --timestamps

#to prune all stopped containers
docker container prune -f
docker container ls -a # list all running and stopped containers

#to stop and remove the server003 
docker container stop server003
docker container rm server003

#to remove the running container with force
docker container rm -f web01 web02 web03 server02
docker container ls -a # list all running and stopped containers

#to remove all downloaded images
docker image rm nginx centos:7

# to do the total cleanup 
docker container rm `docker container ls -a -q` -f


