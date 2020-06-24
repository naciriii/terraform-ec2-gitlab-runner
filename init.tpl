#!/bin/bash

# Install docker
apt-get update
apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
apt-get update
apt-get install -y docker-ce
usermod -aG docker ubuntu

# Install docker-compose if needed
curl -L https://github.com/docker/compose/releases/download/1.21.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Install gitlab runner
sudo apt-get update
curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh | sudo bash
sudo apt-get install gitlab-runner
# Register the gitlab runner by project token
sudo gitlab-runner register --non-interactive --url "https://gitlab.com/" --registration-token ${gitlab_token} \
  --executor docker --docker-image "ruby:2.5" --name "ec2-gitlab-runner"  --tag-list "ec2-gitlab-runner" \
  --locked=false --run-untagged=true --access-level= "not_protect"
# Set concurrent to 4 instead of 1 to allow running multi jobs
sudo sed -i -e '/concurrent/s/1/4/' /etc/gitlab-runner/config.toml
# Verify the runner and delete unsused
sudo gitlab-runner verify --delete

