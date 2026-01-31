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

