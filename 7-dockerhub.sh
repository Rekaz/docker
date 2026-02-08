# dockerhub: docker hub is a cloud based repository service provided by docker, inc
# it contains various free repositories that contains docker images which are pre built, containerized applications.

echo -e '\033[0;32mStep 1: signup with docker hub \033[0m'
# sign up here to create an account on docker hub: https://hub.docker.com/
#once it is done, run docker login
docker login
# pull an image
docker image pull alpine
# list the images
docker images ls

echo -e '\033[0;32mStep 2: Tag an image \033[0m'
docker image tag alpine eyesoncloud/alpine:ver1
docker image ls

echo -e '\033[0;32mStep 3: Push an image to docker hub \033[0m'
docker image push eyesoncloud/alpine:ver1
# you can verify the recently pushed image in your dockerhub account

# remove the local image
docker image rm eyesoncloud/alpine:ver1
docker image ls
#pull the image
docker image pull eyesoncloud/alpine:ver1

echo -e '\033[0;32mStep 4: Cleanup \033[0m'
docker image ls
# docker container rm `docker image ls -a -q` -f # no need since no container is running
docker image rm `docker image ls -a -q` -f

