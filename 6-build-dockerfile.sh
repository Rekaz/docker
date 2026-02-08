# dockerfile: docker build command can be used to create docker images from dockerfile and context. Dockerfile tells us what type of environment goes into the container.
# A build's context is a set of files present at certain path or URL
#

echo -e '\033[0;32mStep 1: Create a dockerfile \033[0m'
mkdir ~/docker/example
cd ~/docker/example
# create a dockerfile inside example folder
cat > Dockerfile <<EOF
FROM ubuntu:24.04
RUN apt-get update && apt-get install -y nginx
RUN rm -f /usr/share/nginx/html/*
COPY index.html /usr/share/nginx/html/
RUN sed -i 's|root /var/www/html;|root /usr/share/nginx/html;|g' /etc/nginx/sites-enabled/default
EXPOSE 80/tcp
CMD ["nginx", "-g", "daemon off;"]
EOF
# create a file that gets copied inside the container. Basically, it can be included into build's context
cat > index.html << EOF
Welcome to Docker Learning
EOF
# list the current directory
ls


echo -e '\033[0;32mStep 2: building an image from dockerfile \033[0m'
docker image build -t ubuntu:nginx .
docker image ls

echo -e '\033[0;32mStep 3: run the container using newly built image\033[0m'
docker container run --name web-nginx -dit ubuntu:nginx
docker container ls
docker container inspect web-nginx | grep IPAddress
docker container inspect web-nginx | grep -e "HostPort" -e "IPAddress" | uniq
curl 172.17.0.2

echo -e '\033[0;32mStep 4: cleanup \033[0m'
docker container rm `docker container ls -a -q` -f
docker image rm `docker image ls -q` -f