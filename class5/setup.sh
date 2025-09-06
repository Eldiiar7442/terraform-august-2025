#!//bin/bash

sudo yum install httpd -y 
sudo systemctl start httpd 
sudo systemctl enable httpd 
sudo yum install tree -y

wget https://releases.hashicorp.com/terraform/1.13.1/terraform_1.13.1_linux_amd64.zip
unzip terraform_1.13.1_linux_amd64.zip
sudo mv terraform /usr/locol/bin/