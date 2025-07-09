#!/bin/bash/
sudo apt update

#openjdk-21 installation
echo "openjdk-21 installation"
sudo apt install fontconfig openjdk-21-jre
java --version

#jenkins installation
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian/jenkins.io-2023.key
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins
echo "Jenkins version"
jenkins --version
echo "To display the jenkins status"
systmctl status jenkins
