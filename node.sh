#!/bin/bash 

# Update system packages
sudo yum update -y
sudo yum install -y curl

curl -fsSL https://rpm.nodesource.com/setup_23.x -o /home/ec2-user/nodesource_setup.sh
sudo bash /home/ec2-user/nodesource_setup.sh
sudo yum install -y nodejs
node -v