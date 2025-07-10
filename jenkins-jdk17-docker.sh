#!/bin/bash
sudo apt update -y
sudo apt updrage -y
#Installing jdk-17
echo "Installing Jdk-17"
sleep 10
sudo apt install fontconfig openjdk-17-jre -y
java --version
sleep 10
#Adding java binary
echo "adding java binary"
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt update -y
sudo apt upgrade -y
sleep 10
echo "installing jenkins"
sudo apt install jenkins -y
echo "jenkins --version"
sleep 10
systemctl status jenkins.service
# Add Docker's official GPG key:
sudo apt update -y
#Installing ca-certificates curl
sudo apt install ca-certificates curl -y
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update -y
sudo apt upgrade -y
sleep 10
#installing Docker
echo "Installing Docker"
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo apt install docker-compose -y
sleep 10
echo "Adding ubuntu user to docker group"
sudo usermod -aG docker ubuntu
newgrp docker
echo "ubuntu added to docker group successfully"
