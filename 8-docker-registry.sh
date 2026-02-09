# docker registry: used when we want to create our own private repository. Unlike docker hub, which is public, and anyone can access it. 
echo -e '\033[0;32mStep 1: Start a Registry Service as a Container \033[0m'
docker container run --name local-reg -d --restart=always -p 5000:5000 registry:2
docker container ls -a # list the containers running/stopped
#configure the local repository to be used by docker as insecure, we do this so that docker daemon trust this private registry, when it is running on localhost:5000. Docker daemon will trust the private registry which don't have HTTP/HTTPS encryption, if we add the below lines in /etc/docker/daemon.json
cat <<EOF |sudo tee /etc/docker/daemon.json 
{
"insecure-registries":[
"localhost:5000"
]
}
EOF
sudo systemctl restart docker #restart docker

echo -e '\033[0;32mStep 2: Pull an image from a local registry \033[0m'
docker image pull ubuntu:20.04
docker image ls
docker image tag ubuntu:20.04 localhost:5000/my-ubuntu
docker image ls

echo -e '\033[0;32mStep 3: Push an image to a local registry \033[0m'
docker image push localhost:5000/my-ubuntu
docker image ls
docker image rm localhost:5000/my-ubuntu ubuntu:20.04 # remove the images
docker image ls
docker image pull localhost:5000/my-ubuntu
docker image ls
# now for testing, remove the private docker registry container, registry:2 and try to pull localhost/5000 image again
docker container stop local-reg
docker container ls -a
docker container ls
docker container rm local-reg
docker container ls -a
docker container ls
docker image pull localhost:5000/my-ubuntu
docker image rm registry:2
docker image pull localhost:5000/my-ubuntu
docker container run --name local-reg -d -p 5000:5000 registry:2

echo -e '\033[0;32mStep 4: Cleanup \033[0m'
docker container rm local-reg -f
docker image rm `docker image ls -a -q` -f