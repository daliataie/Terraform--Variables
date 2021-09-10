aws_region     = "us-east-1"
AWS_ACCESS_KEY = "AKIAW4L22JFM3T6ALVVX"
AWS_SECRET_KEY = "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"

vpc_cidr           = "10.0.0.0/16"
public_subnet_cidr = "10.0.2.0/24"
az1                = "us-east-1a"

/* for multi subnets and multi az's
public_subnets = ["10.0.32.0/20", "10.0.96.0/20", "10.0.160.0/20"]
azs            = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
*/

route_cidr_block = "0.0.0.0/0"

ami                         = "ami-0c2b8ca1dad447f8a"
instance_type               = "t2.micro"
associate_public_ip_address = "true"
instance_count              = "3"
instance_tags               = ["mysql_db"]