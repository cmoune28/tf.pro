variable "aws_region" {
  default = "us-east-1"
}

variable "AMIS" {
  type = map(any)
  default = {
    us-east-1 = "ami-06aa3f7caf3a30282"
    us-east-2 = "ami-07b36ea9852e986ad"
    us-west-2 = "ami-08e2c1a8d17c2fe17"
  }
}

variable "instance-type" {
  default = "t2.micro"
}

variable "Priv_key_path" {
  default = "vprofilekey"
}

variable "Pub_key_path" {
  default = "vprofilekey.pub"
}

variable "username" {
  default = "ubuntu"
}

variable "MYIP" {
  default = "76.187.44.86/32"
}

variable "rmquser" {
  default = "rabbit"
}

variable "rmqpass" {
  default = "P@ssword123456"
}

variable "dbpass" {
  default = "admin123"
}

variable "dbuser" {
  default = "admin"
}

variable "dbname" {
  default = "accounts"
}

variable "instance_count" {
  default = "1"
}

variable "VPC_name" {
  default = "My-VPC"
}

variable "Zone1" {
  default = "us-east-1a"
}

variable "Zone2" {
  default = "us-east-1b"
}

variable "Zone3" {
  default = "us-east-1c"
}

variable "VPC_CIDR" {
  default = "10.21.0.0/16"
}

variable "Pub_SN_1_CIDR" {
  default = "10.21.1.0/24"
}

variable "Pub_SN_2_CIDR" {
  default = "10.21.2.0/24"
}

variable "Pub_SN_3_CIDR" {
  default = "10.21.3.0/24"
}

variable "Priv_SN_1_CIDR" {
  default = "10.21.4.0/24"
}

variable "Priv_SN_2_CIDR" {
  default = "10.21.5.0/24"
}

variable "Priv_SN_3_CIDR" {
  default = "10.21.6.0/24"
}



variable "my_profile" {
  default = "IAM_DevOps"
}