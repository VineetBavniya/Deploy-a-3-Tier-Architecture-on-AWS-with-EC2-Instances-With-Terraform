#!/bin/bash

# Update system packages
sudo yum update -y
sudo yum install git -y 

# Change to home directory of ec2-user
cd /home/ec2-user

# Clone the repo
sudo git clone https://github.com/Learn-It-Right-Way/lirw-react-node-mysql-app.git
cd lirw-react-node-mysql-app
