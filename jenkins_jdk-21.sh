#!/bin/bash/
sudo apt update -y
sudo apt upgrade -y

#openjdk-21 installation
echo "openjdk-21 installation"
sleep 10
sudo apt install fontconfig openjdk-21-jre -y
java --version
sleep 10


#jenkins installation
echo "jenkins installation"

sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian/jenkins.io-2023.key
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update -y
sudo apt-get install jenkins -y
echo "Jenkins version"
jenkins --version
sleep 10
echo "To display the jenkins status"
systemctl status jenkins.service
