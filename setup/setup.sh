#!/bin/bash

# Exit script on any error
set -e

echo "Updating package index and upgrading installed packages..."
sudo apt update && sudo apt upgrade -y

echo "Installing Java (OpenJDK 11)..."
sudo apt install -y openjdk-11-jdk

echo "Verifying Java installation..."
java -version

echo "Adding Jenkins GPG key and repository..."
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee \
    /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
    https://pkg.jenkins.io/debian binary/ | sudo tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null

echo "Updating package index and installing Jenkins..."
sudo apt update
sudo apt install -y jenkins

echo "Starting and enabling Jenkins service..."
sudo systemctl enable jenkins
sudo systemctl start jenkins

echo "Checking Jenkins status..."
sudo systemctl status jenkins

echo "Fetching Jenkins initial admin password..."
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

echo "Installation complete! Access Jenkins at: http://<YOUR_VM_IP>:8080"
echo "Use the above password to unlock Jenkins on the first login."
