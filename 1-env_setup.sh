#to begin installation, prepare the environment

# step 1: disable the ufw (uncomplicated firewall)
sudo systemctl disable ufw

#step 2: disable apparmor
sudo systemctl disable apparmor

#step3: check the status whether they are disabled or not

sudo systemctl status ufw --no-pager
sudo systemctl status apparmor --no-pager

#step 4: run update and upgrade

sudo apt-get update
sudo apt-get upgrade