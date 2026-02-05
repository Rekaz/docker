# export a container as a tarball: encapsulates the current filesystem and state of the container into a compressed file. 
# import a container from the tarball: enables swift deployment and versioning of complex application configurations
echo -e '\033[0;32mStep 1: start a container \033[0m'
docker run --name nginx-first -dit nginx:1.20

echo -e '\033[0;32mStep 2: list the images and containers (running or exited) \033[0m'
docker image ls
docker container ls
docker container ls -a

echo -e '\033[0;32mStep 3: inspect the history of the image \033[0m'
#"docker image history nginx-first": this will fail, because nginx-first is the name of the container not the image, but we are running inspect command on image
docker image history nginx:1.20

echo -e '\033[0;32mStep 4: Export the container state as a tarball \033[0m'
docker container export nginx-first -o nginx-first-exported.tar

echo -e '\033[0;32mStep 5: list the file \033[0m'
# tar -tvf nginx-first-exported.tar  # this lists the contents of the tar file
ls -lah nginx-first-exported.tar

echo -e '\033[0;32mStep 6: remove the container and delete the image \033[0m'
docker container rm nginx-first -f # "docker container rm nginx-first", won't work, since container is still running, either first stop it or use -f to remove it forcefully
# "docker image rm nginx-first" : won't work since docker nginx-first is not the image, it is container
docker image rm nginx:1.20

echo -e '\033[0;32mStep 7: import the tarball \033[0m'
docker image import nginx-first-exported.tar nginx-new:v1

echo -e '\033[0;32mStep 8: check the history of the image and run it \033[0m'
docker image history nginx-new:v1
docker image ls
docker container ls
# "docker run --name nginx-new-imported -dit nginx-new:v1": won't work because when we use export and then import, it strips the image history and metadata to create the 'flat' filesystem

echo -e '\033[0;32mStep 9: cleanup \033[0m'
# docker container rm `docker container ls -a -q` -f
docker image rm `docker image ls -q` -f
