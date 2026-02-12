# docker network: used for the communication between different containers and between containers and outside world
# It abstracts the underlying host network and give networking capabilities to the containers
# docker networking helps a container to get attached to many networks as it like. We can attach docker network to the running container as well.
echo -e '\033[0;32mStep 1: Characteristics of the Default Bridge Network \033[0m'
docker network ls # lists the network
docker network inspect bridge # inspect the 'bridge' network
# run two containers and see if they are attached to "bridge" network or not
docker container run --name server01 -dit nginx
docker container run --name server02 -dit nginx
docker network inspect bridge | grep Containers -A 15
# try to find the IP addesses of each of these running containers
docker container inspect server01 | grep IPAddress
docker container inspect server02 | grep IPAddress
# attach to one of the running container and try to ping to other running container, you should be able to ping because both the containers are attached to the same docker "bridge" network. Also, try to ping google.com from the container.
docker container attach server01
ip a s
ping -c 2 172.17.0.2
ping -c 2 172.17.0.3
ping -c 2 www.google.com
# press ctrl +p+q to come out of container gracefully.

# now repeat the same thing with other container. Attach to it and then ping the other container and google.com
docker container attach server02
ip a s
ping -c 2 172.10.0.3
ping -c 2 172.17.0.2
ping -c 2 www.google.com
# press ctrl +p+q to come out of container gracefully.
docker container rm `docker container ls -a -q` -f # stop the running containers and remove them

echo -e '\033[0;32mStep 2: Understanding Custom (User-Defined) Bridge Networks \033[0m'


