# docker compose: docker compose is a tool used to run multi container docker applications.
# it uses a yaml (dcker-compose.yml) to configure service, resources used by the application
# then, with single command, we can create and start all the services from the configuration.

echo -e '\033[0;32mStep 1: Install docker compose \033[0m'
sudo apt install -y docker-compose-plugin
docker compose version # tells the docker compose version

echo -e '\033[0;32mStep 2: Create a Ghost Blog and MySQL Service \033[0m'
mkdir ~/docker/ghost-app
cd ~/docker/ghost-app
# download the docker compose yaml
wget https://raw.githubusercontent.com/EyesOnCloud/docker/main/docker-compose.yml 

cat -n docker-compose.yml # view the manifest file

echo -e '\033[0;32mStep 3: Bring Up the Ghost Blog Service \033[0m'
docker compose up -d
# verify that it is running, on localhost:80

echo -e '\033[0;32mStep 4: Cleanup \033[0m'
docker compose stop
docker compose rm -f # remove the containers
docker compose down # remove the user defined network created
docker image rm `docker image ls -q` -f
docker volume prune -f
docker network prune -f
