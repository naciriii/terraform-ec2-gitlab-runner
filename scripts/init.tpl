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
#Unregister old runners
sudo gitlab-runner unregister --all-runners
# Register the first gitlab runner by project token
sudo gitlab-runner register --non-interactive --url ${runner_url} --registration-token ${gitlab_token} \
  --executor ${runner_executor}  --docker-image ${runner_default_docker_image} --name ${runner_name} --tag-list ${runner_tags}  \
  --locked=${runner_locked} --docker-privileged --run-untagged=${runner_run_untagged} --access-level="not_protected" --docker-volumes /var/run/docker.sock:/var/run/docker.sock


# Register other runners if exist with suffixed names
for (( i=2; i<=${runners}; i++ ))
do
TAGS=$(echo ${runner_tags} | sed "s/,/$i,/g" | sed "s/$/$i/")
sudo gitlab-runner register --non-interactive --url ${runner_url} --registration-token ${gitlab_token} \
  --executor ${runner_executor}  --docker-image ${runner_default_docker_image} --name ${runner_name}-$i --tag-list $TAGS  \
  --locked=${runner_locked} --docker-privileged --run-untagged=${runner_run_untagged} --access-level="not_protected" --docker-volumes /var/run/docker.sock:/var/run/docker.sock

done
# Set concurrent to 4 instead of 1 to allow running multi jobs
sudo sed -i -e '/concurrent/s/1/${concurrent_limit}/' /etc/gitlab-runner/config.toml
# Verify the runner and delete unsused
sudo gitlab-runner verify --delete

