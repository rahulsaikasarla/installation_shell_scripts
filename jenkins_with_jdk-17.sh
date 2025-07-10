#!/bin/bash
sudo apt update
echo "Installing Jdk-17"
sleep 10
sudo apt install fontconfig openjdk-17-jre -y
java --version
sleep 10
echo "adding java binary"
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update -y
sleep 10
echo "installing jenkins"
sudo apt-get install jenkins -y
echo "jenkins --version"
sleep 10
systemctl status jenkins.service
