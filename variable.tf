variable "aws_region" {
  default = " us-east-1"
}
variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR for the public subnet"
  default     = "10.0.2.0/24"
}

variable "az1" {
  type        = string
  description = "List of Availability Zones (e.g. `['us-east-1a', 'us-east-1b', 'us-east-1c']`)"
  default     = "us-east-1a"
}

variable "route_cidr_block" {
  description = "cidr for route table"
  default     = "0.0.0.0/0"
}

variable "ami_id" {
  description = "Linux ami"
  type        = map(any)
  default = {
    us-east-1 = "ami-0c2b8ca1dad447f8a"
  us-east-2 = "ami-00dfe2c7ce89a450b" }
}
variable "instance_type" {
  default = "t2.micro"
}

variable "associate_public_ip_address" {
  description = "enable public ip address"
  type        = bool
  default     = "true"
}

variable "instance_count" {
  default = "2"
}

variable "instance_tags" {
  type    = list(any)
  default = ["mysql_db", "database2"]
}



/*full block ami and default when having two az i believe
  
  variable "ami" {
  type = "map"

  default = {
    "us-east-1" = "ami-0c2b8ca1dad447f8a"
     }
}


variable "availability_zones" {
  type        = list(string)
  description = "List of Availability Zones (e.g. `['us-east-1a', 'us-east-1b', 'us-east-1c']`)"
  type = "us-east-1a"
}
variable "AWS_ACCESS_KEY"{
default = "AKIAW4L22JFM3T6ALVVX"
   type = "string"
   description = "access key"
}

   variable "AWS_SECRET_KEY"{
default = "cy6G2lPnKB7eLwmwoa0jd/iZI2/ak6u62PhGoCdI"
  type = "string"
   description = "secret key"
   }

variable "aws_region" {
 default = "us-east-1"
  type = "string"
  description = "region for the vpc"
 }

*/
