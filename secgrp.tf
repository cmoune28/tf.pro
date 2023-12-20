resource "aws_security_group" "vpro-bean-elb-sg" {
  name = "vpro-bean-elb-sg"
  description = "Security group for bean-elb"
  vpc_id = module.VPC.vpc_id 
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "vpro-bastion-sg" {
  name = "vpro-bastion-sg"
  description = "Security group for bastion - Ec2 instance"
  vpc_id = module.VPC.vpc_id
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = [var.MYIP]
  }  
}

resource "aws_security_group" "vpro-prod-sg" {
  name = "vpro-prod-sg"
  description = "Security group for beanstalk instances"
  vpc_id = module.VPC.vpc_id
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    security_groups = [aws_security_group.vpro-bastion-sg.id]
  }  
}

resource "aws_security_group" "vpro-backend-sg" {
  name = "vpro-backend-sg"
  description = "Security group for RDS, active mq, elastic cache"
  vpc_id = module.VPC.vpc_id
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    security_groups = [aws_security_group.vpro-prod-sg.id]
  }  
}

resource "aws_security_group_rule" "sec_group_allow_itself" {
  type = "ingress"
  from_port = 0
  to_port = 65535
  protocol = "tcp"
  security_group_id = aws_security_group.vpro-backend-sg.id
  source_security_group_id = aws_security_group.vpro-backend-sg.id
}