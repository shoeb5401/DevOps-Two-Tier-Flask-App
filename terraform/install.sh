#!/bin/bash
# Update and install required packages 
sudo apt update && sudo apt upgrade -y
sudo apt install git docker.io docker-compose-v2 -y
# Start and setup the docker 
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER
newgrp docker
#Install Jenkins and its dependencies 
sudo apt install openjdk-17-jdk -y

sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt update
sudo apt install jenkins -y 

# Start the jenkins service
sudo systemctl start jenkins
sudo systemctl enable jenkins

sudo usermod -aG docker jenkins
sudo systemctl restart jenkins