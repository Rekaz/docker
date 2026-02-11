# docker volume: Using this, data can persist outside the lifesycle of the container. Data generated during the runtime of container can be persisted using docker volume even if we stop the container.
# volumes have various advantages over bind mounts. docker volume is managed by docker but bind mounts are managed by OS. docker volume isolation is high (non docker processes can't access the data), but in bind mounts, isolation is low (any process can access the data).
# location: for docker volume: managed by docker in /var/lib/docker/volumes, anywhere on the host: /home/user/app

echo -e '\033[0;32mStep 1: Create and manage volumes \033[0m'
docker volume ls # lists the docker volumes
docker volume create # creates a volume without name
docker volume create my-vol # create the volume with name "my-vol"
docker volume ls
docker volume inspect my-vol # inspect the volume my-vol
docker volume rm my-vol # remove the volume

echo -e '\033[0;32mStep 2: Create or start the container with volume \033[0m'
# if we start the container with a volume but that volume doesn't exist, docker will create the volume and then mounts that volume into some location inside the container
docker container run --name devtest -dit -v myvol2:/app nginx:latest
# inspect the container to see if volume was mounted correctly
docker container inspect devtest | grep "Mounts" -A 10
# stop the container
docker container stop devtest
# remove the container 
docker container rm devtest
#remove the volume
docker volume rm myvol2

echo -e '\033[0;32mStep 3: Persist a Volume Using Container (Write Data to the Volume) \033[0m'
docker container run --name nginxtest -dit -v nginx-vol:/usr/share/nginx/html nginx:latest #/usr/share/nginx/html is the place where nginx stores default HTML content

#create a file (indx.html) inside the docker volume
cat << EOF | sudo tee /var/lib/docker/volumes/nginx-vol/_data/index.html
"HELLO FROM DOCKER"
EOF

#inspect the IP address
docker container inspect nginxtest | grep -i ipaddress
curl 172.17.0.2
docker container stop nginxtest # stop the container
docker container rm nginxtest # remove the container
# verify if data persists
sudo cat /var/lib/docker/volumes/nginx-vol/_data/index.html
docker volume rm nginx-vol

echo -e '\033[0;32mStep 4: Use a read-only Volume \033[0m'
# mount a volume as read only
docker container run --name nginxtest -dit -v nginx-vol:/usr/share/nginx/html:ro nginx:latest
#inspect the volume
docker container inspect nginxtest | grep "Mounts" -A 10
# try to create a file inside the container at the mounted volume
docker container exec nginxtest touch /usr/share/nginx/html/testfile
docker container stop nginxtest
docker container rm nginxtest
docker volume rm nginx-vol

echo -e '\033[0;32mStep 5: Cleanup \033[0m'
docker image rm `docker image ls -a -q` -f
docker volume prune -f
