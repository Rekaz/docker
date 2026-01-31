# list the containers 
docker container ls -a

# create a nginx container
docker contianer create nginx

docker container ls -a # verify the container's present or not

# create a container with a proper name "Web01"
docker container create nginx --name web01

docker container ls -a # to see that new container with image nginx got the name as web01

# to start the container (it will start running)
docker container start web01

docker container ls # list the containers that are running

# create a container using run, (create + start = run)
docker container run centos --name server01

docker container ls -a # list running containers as well as exited containers

# create a container using run and adding -i -t for interactive terminal
docker container run centos --name server02 -i -t
# the below two commands ran inside the container that we started above in the interactive mode
ps 
exit

# create a container and it starts in detached mode (it runs in background)
docker container run centos --name server03 -dit

docker container ls -a # to list all running and exited containers

# to attach with the running container
docker container attach server03

ps

# to exit the container, use ctrl + pq

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
docker container run nginx --name web02 -dit -p 8080:80 # container port is 80 and it is exposed to port 8080 of host

docker container ls -a # list all running and exited containers

# create a container and expose it to random port (host port default dynamic range is 32768-60999)
docker container run nginx --name web03 -dit -P 

docker container ls -a # list all running and exited containers

# inspect a container
docker container inspect web02 | grep -e "HostPort" -e "IPAddress" | uniq

curl 172.17.0.2 # to access the webserver by using container IP

