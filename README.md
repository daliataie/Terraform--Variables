09/10/2021


Mysql info:

Username: xxxx

password: xxxxx

Port: 3306 and 22 

Database name: xxxxxxxe

Ec2 information:

Public key: xx.xx.xx.xx


Requirements:
I want to create EC2 instance in AWS  and install  MySQL database in it
Create Security group allow incoming traffic to database


Username: itexps
password: ITexps@123
Port:  
Database name: 
Try to use variable and configuration details in different file, so each environment I can change the above details.
Configure service to start as soon as instance start
You can use windows or Linux AMI


1-	Creating , VPC, internet gateway, route table and public subnet with 2 instances insides, all codes for each resource are available in terraform main,tf file. 
2-	Create a security group to allow access through port 
3-	Automate installing mysql from A-Z, to be installing after the ec2 initiating, there was lots of difficulties in doing that because installing MySQL require answering yes or no questions and initiating root user and use it to enter the MySQL  and automate this is not an easy job.
4-	Terraform files ( main.tf, variable.tf and terraform.tfvars ), using following commands:
-	Terraform init- to download the aws plug inn.
-	Terraform apply to create all resources and vpc-infrastructure .
-	Terraform fmt, to correct spaces mistakes in the code.
-	Terraform plan , to review the infrastructure before building
-	Terraform destroy to delete everything.
5-	Continuous testing the code manually, each command was tested individually on ec2 before run it on terraform , I troubleshoot tens of errors.
6-	I used putty with the ppk key to get into ec2, also ssh command to check if the ec2 working remotely.
7-	Git commands to create repository and push the file to github repository:
-	Create a folder in the local machine , mkdir *folder name) and be inside it.
-	Git init to create an empty repo
-	Git add –all to add files inside that folder to staging area .
-	Add commit -m”” to commit changes.
-	Go github and create repo .
-	create a connection between the local and the remote repository by running
-	git remote add origin https://github.com/xxx/xx.git 
-	branch -M main
-	git push -u origin main
-	Run git push "http......" to push the local repo to remote repo, then go and check the repository in github. 
8-	Ssh the ec2  ssh -i "xxx.pem" ec2-user@44.193.203.244 and check if  the MySQL been installing with the user and database and password set by the instructor.
Use Linux command in your ec2 as follows:
-	Mysql -u root -p and hit enter 
-	Check if mysql been installed ( mysql –version)
-	Run command (SELECT USER,host from mysql.user;) to get list of users
-	Run command  (SHOW DATABASES;) to get list of databases) 




