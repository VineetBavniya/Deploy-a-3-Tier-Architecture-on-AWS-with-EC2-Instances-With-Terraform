
##  Deploy a 3-Tier Architecture on AWS with EC2 Instances 

###### This project is a full-stack web application built using React js for the frontend, Express js for the backend, and MySQL as the database. The application is designed to demonstrate the implementation of a 3-tier architecture, where the presentation layer (React js), application logic layer (Express js), and data layer (MySQL) are separated into distinct tiers.

### Put Access_key and Secret_key in provider.tf 
```
provider "aws" {
  # Configuration options
  region     = "us-east-1"
  access_key = "" // put here access_key 
  secret_key = "" // put here secret_key 
}

```

### change key_name all instance resource database, application instance

```
filename -: presentation.tf , application.tf data.tf 
resource "aws_instance" "presentation_instance" {
  ami           = "ami-05b10e08d247fb927" // only use amazon linux image 
  instance_type = "t2.micro"
  key_name      = "put_name_here_pem_key" // change key name 
 ....more
}
```

### Run Terraform 

```
terraform init 
terraform apply --auto-approve 
```

## User Interface Screenshots


## Connecting to presentation EC2 instance via a host
#####    1. To change the ssh key permission 
####    
```bash 
chmod 400 filename.pem 
```

#####    2. To ssh into bastion host with agent forwarding:
####    
```bash 
scp -i "filename.pem" filename.pem ec2-user@:public_ip_of_presentation_instance/home/ec2-user/

ssh -i filename.pem ec2-user@public_ip_of_presentation_instance  

### if You want to connect database instance  

scp -i "filename.pem" filename.pem ec2-user@:private_ip_of_applicaltion_instance/home/ec2-user/
```

#####    3. Now connect to the application instance
####    
```bash 
you need a filename.pem key here on this instance to connect application instance

ssh -i filename.pem ec2-user@private_ip_of_application_instance

open the db.js file 


```

```
cd lirw-react-node-mysql-app/backend/configs/db.js 
sudo vim db.js
and change user, password,

const mysql = require('mysql2');
const db = mysql.createConnection({
   host: 'localhost', // put here your database-Instance-private-Ip 
   port: '3306',
   user: 'root', // put here  appuser 
   password: '12345678', // put her  Password@123
   database: 'react_node_app'
});

module.exports = db; 

```

### now install npm package 
```
sudo npm install 

sudo npm install -g pm2 

sudo npm run serve

sudo pm2 logs server

check connection proper now exit this machine go the presentation instance 

``` 

### configure presentation instance 
``` 
cd lirw-react-node-mysql-app/frontend/

create .env file and put this inside 
VITE_API_URL="/api"

now install packages

sudo npm install 

sudo npm run build

sudo cp -r dist /usr/share/nginx/html

``` 

### configure nginx 
#### open nginx.conf file 
``` 
sudo vim /etc/nginx/nginx.conf 
.....
    server {
        listen       80;
        listen       [::]:80;
        server_name  _;
        root /usr/share/nginx/html/dist;
        location /api {
            proxy_pass http://put_your_application_instance_private_ip:3200/api; add 
        }

        # Load configuration files for the default server block.
        include /etc/nginx/default.d/*.conf;

        

        error_page 404 /404.html;
        location = /404.html {
        }

        error_page 500 502 503 504 /50x.html;
        location = /50x.html {
        }
    }
    .....more 


```
#### Now Restart nginx
```
sudo systemctl restart nginx   
```

### Youtube Link of this project 

``` 
https://www.youtube.com/watch?v=hHyXXAtKA5s&list=WL&index=6 
```
