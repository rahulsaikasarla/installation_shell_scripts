#!/bin/bash

#update the server
echo "Updating system packages..."
sudo apt update && sudo apt upgrade -y

#Now install openjdk here i'm using jdk-17
echo "Installing OpenJDK 17"
sudo apt install openjdk-17-jdk -y
echo "java version"
java -version


#Now install postgresql and start
echo "Installing PostgreSQL"
sudo apt install postgresql postgresql-contrib -y
echo "status"
sudo systemctl start postgresql
sleep 5
sudo systemctl enable postgresql

#Create user
#sudo -i -u postgres

#Now createuser sonar
echo "Configuring PostgreSQL for SonarQube user and database."
sudo -u postgres psql <<EOF
CREATE USER sonar WITH ENCRYPTED PASSWORD 'sonar';
CREATE DATABASE sonarqube OWNER sonar;
EOF

#Download sonarqube
echo "Downloading SonarQube"
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-10.5.1.90531.zip
sleep 3
#To unzio files Install unzip application 
sudo apt install unzip -y
unzip sonarqube-10.5.1.90531.zip 

#Move dir to /opt
sudo mv sonarqube-10.5.1.90531 /opt/sonarqube
#Now add sonarqube user and also permissions 
sudo groupadd sonar
sudo useradd -d /opt/sonarqube -g sonar sonar
sudo chown -R sonar:sonar /opt/sonarqube

#Now add dir for sonarqube logs with permissions
sudo mkdir -p /opt/sonarqube/logs
sudo chown -R sonar:sonar /opt/sonarqube/logs

#Taking backup before adding
sudo cp /opt/sonarqube/conf/sonar.properties sonar.properties_backup

#Now add below lines to sonar.properties
cat <<EOF | sudo tee /opt/sonarqube/conf/sonar.properties
sonar.jdbc.username=sonar
sonar.jdbc.password=sonar
sonar.jdbc.url=jdbc:postgresql://localhost/sonarqube
sonar.path.logs=/opt/sonarqube/logs
EOF

#To add manual run and add below -> sudo nano /opt/sonarqube/conf/sonar.properties
#sonar.jdbc.username=sonar
#sonar.jdbc.password=sonar
#sonar.jdbc.url=jdbc:postgresql://localhost/sonarqube
#sonar.path.logs=/opt/sonarqube/logs   


# Adding service 
cat <<EOF | sudo tee /etc/systemd/system/sonarqube.service
[Unit]
Description=SonarQube service
After=syslog.target network.target

[Service]
Type=forking
ExecStart=/opt/sonarqube/bin/linux-x86-64/sonar.sh start
ExecStop=/opt/sonarqube/bin/linux-x86-64/sonar.sh stop
User=sonar
Group=sonar
Restart=always
LimitNOFILE=65536
LimitNPROC=4096
LimitAS=infinity
LimitFSIZE=infinity
PIDFile=/opt/sonarqube/temp/sonar.pid

[Install]
WantedBy=multi-user.target
EOF

# Reload systemctl and start SonarQube
sudo systemd-analyze verify /etc/systemd/system/sonarqube.service
sudo chown -R sonar:sonar /opt/sonarqube
sudo chmod -R 755 /opt/sonarqube
sudo systemctl daemon-reload
sudo systemctl enable sonarqube
sudo systemctl start sonarqube

