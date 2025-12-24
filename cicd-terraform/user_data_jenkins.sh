#!/bin/bash
set -e

apt update -y
apt upgrade -y

# Install Java
apt install -y openjdk-17-jdk

# Install Docker
apt install -y docker.io
systemctl start docker
systemctl enable docker
usermod -aG docker ubuntu
usermod -aG docker jenkins || true

# Install Jenkins
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

apt update -y
apt install -y jenkins

systemctl start jenkins
systemctl enable jenkins

# Install AWS CLI
apt install -y awscli

