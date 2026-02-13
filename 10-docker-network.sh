# docker network: used for the communication between different containers and between containers and outside world
# It abstracts the underlying host network and give networking capabilities to the containers
# docker networking helps a container to get attached to many networks as it like. We can attach docker network to the running container as well.
echo -e '\033[0;32mStep 1: Characteristics of the Default Bridge Network \033[0m'
docker network ls # lists the network
docker network inspect bridge # inspect the 'bridge' network
# run two containers and see if they are attached to "bridge" network or not
docker container run --name server01 -dit centos:7
docker container run --name server02 -dit centos:7
docker network inspect bridge | grep Containers -A 15
# try to find the IP addesses of each of these running containers
docker container inspect server01 | grep IPAddress
docker container inspect server02 | grep IPAddress
# attach to one of the running container and try to ping to other running container, you should be able to ping because both the containers are attached to the same docker "bridge" network. Also, try to ping google.com from the container.

# docker container attach server01 # not using this command since it becomes difficult to exit gracefully on vs code, because we need to press ctrl +p and then ctrl +q  to come out of container gracefully. ctrl +p command is basically a shortcut to "open file" in vs code.
docker container exec -it server01 sh 
ip a s
ping -c 2 172.17.0.2
ping -c 2 172.17.0.3
ping -c 2 www.google.com
# press ctrl +p+q to come out of container gracefully.

# now repeat the same thing with other container. Attach to it and then ping the other container and google.com
docker network inspect bridge | grep Containers -A 15
# docker container attach server02 # not using this command since it becomes difficult to exit gracefully on vs code, because we need to press ctrl +p and then ctrl +q  to come out of container gracefully. ctrl +p command is basically a shortcut to "open file" in vs code.
docker container exec -it server02 sh 
ip a s
ping -c 2 172.17.0.3
ping -c 2 172.17.0.2
ping -c 2 www.google.com
# 
docker container rm `docker container ls -a -q` -f # stop the running containers and remove them

echo -e '\033[0;32mStep 2: Understanding Custom (User-Defined) Bridge Networks \033[0m'

# create a bridge by the name "dev-network"
docker network create --driver bridge dev-network
docker network ls # lists the docker network
docker network inspect dev-network # inspect the dev-network, you can see the IP address and also no container is connected to it yet

# create 4 containers 
# you can only attach one network to a container while using docker container run command. To attach a container to more networks, use the docker network connect command.

#dev-container1, dev-cotnaienr2 and dev-container3 are attached to "dev-network" (a user defined network), while the centos-4 container is attached to default network, which is "bridge" network.
docker container run --name dev-container1 -dit --network dev-network centos:7
docker container run --name dev-container2 -dit --network dev-network centos:7
docker container run --name dev-container3 -dit --network dev-network centos:7
docker container run --name centos-4 -dit centos

# bridge network is attached with dev-container3
docker network connect bridge dev-container3

docker container ls
docker network inspect dev-network | grep -i name -A 4
docker network inspect bridge | grep -i name -A 4





