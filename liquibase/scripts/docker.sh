#!/bin/bash
set -e

# Update package lists
apt-get update -y

# Install prerequisites for adding repositories over HTTPS
apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Create directory for Docker's GPG key
install -m 0755 -d /etc/apt/keyrings

# Download Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

# Set up the stable Docker repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package index with Docker packages
apt-get update -y

# Install Docker Engine, CLI, Containerd, and Compose plugin
apt-get install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin

# Enable and start the Docker service
systemctl enable docker
systemctl start docker

# Optional: Add the default 'ubuntu' user to the docker group so you don't need 'sudo'
usermod -aG docker ubuntu

# Output Docker version for validation in cloud-init logs
docker --version