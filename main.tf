
provider "aws" {
  region     = var.aws_region
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
}

resource "aws_vpc" "dbvpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "dbvpc"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.dbvpc.id
  tags = {
    Name = "gateway"
  }
}

resource "aws_subnet" "publicsubnet" {
  vpc_id            = aws_vpc.dbvpc.id
  cidr_block        = var.public_subnet_cidr
  availability_zone = var.az1
  tags = {
    Name = "publicsubnet"
  }
}

/*
variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = [(us-east-1a)]
}
*/

resource "aws_route_table" "rtable" {
  vpc_id = aws_vpc.dbvpc.id
  route {
    cidr_block = var.route_cidr_block
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "publicsubnet rout table"
  }
}

resource "aws_route_table_association" "associate_route_publicsubnet" {
  subnet_id      = aws_subnet.publicsubnet.id
  route_table_id = aws_route_table.rtable.id
}


# create a security group
resource "aws_security_group" "db_security_group" {
  vpc_id = aws_vpc.dbvpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "db_instance" {
  ami                         = lookup(var.ami_id, var.aws_region)
  instance_type               = var.instance_type
  key_name                    = "admin10sasa"
  vpc_security_group_ids      = [aws_security_group.db_security_group.id]
  subnet_id                   = aws_subnet.publicsubnet.id
  associate_public_ip_address = var.associate_public_ip_address
  count                       = var.instance_count
  user_data                   = <<-EOF
                #!/bin/bash
                # update linux package
                sudo yum update -y
                # installing lamp stack
                sudo amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2
                # cats the OS identification data. Can probably be removed
                cat /etc/system-release
                # installing MariaDB
                sudo yum install -y httpd mariadb-server
                # starting MAriaDB
                sudo systemctl start mariadb
                # Logs into mysql/mariadb as root
                mysql -u root 
                # Sets password for the root account
                UPDATE mysql.user SET Password=PASSWORD('$rootpass') WHERE User='root';
                # Deleting root user for local host
                DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
                # Deleting annonymous user
                DELETE FROM mysql.user WHERE User='';
                # Deleting test database
                DELETE FROM mysql.db WHERE Db='test' OR Db='test_%';
                CREATE USER 'test' identified by 'newpassword';
                create user 'itexps' identified by 'ITexps@123';
                # Grant priviliges to user "itexps"
                grant select on *.* to itexps;
                FLUSH PRIVILEGES;
                # Review users
                SELECT USER,host from mysql.user;
                CREATE DATABASE itexpertdatabase;
                SHOW DATABASES;
                exit
                EOF  
  tags = {
    Name = " mysql_db"
  }
}
