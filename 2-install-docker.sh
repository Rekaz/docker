# Docker: a platform used to create, deploy and run the applications using containers
#Containers: contains application along with all its dependencies packages in single unit

#Objectives:
# Step 1: install Prerequisite
# Step 2: Install Docker engine on Ubuntu
# Step 3: Lock the software version

echo -e '\033[0;32mStep 1: install Prerequisite\033[0m'

sudo apt install apt-transport-https ca-certificates curl software-properties-common -y

# Docker uses a GPG key to sign its official packages. Add the key to ensure that packages are trusted.
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo tee /etc/apt/trusted.gpg.d/docker.asc


echo -e '\033[0;32mStep 2: Install Docker engine on Ubuntu\033[0m'
# add Docker’s official repository to your system
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt update -y

#install docker
sudo apt install -y docker-ce docker-ce-cli

# verify docker version
docker --version

#enable docker
sudo systemctl enable docker --now

# check status
sudo systemctl status docker --no-pager


echo -e '\033[0;32mStep 3: Lock the software version\033[0m'
sudo apt-mark hold docker-ce docker-ce-cli
sudo apt-mark showhold