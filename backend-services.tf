resource "aws_db_subnet_group" "vpro-rds-subgrp" {
  name       = "main"
  subnet_ids = [module.VPC.private_subnets[0], module.VPC.private_subnets[1], module.VPC.private_subnets[2]]
  tags = {
    Name = "Subnet group for RDS"
  }
}

resource "aws_elasticache_subnet_group" "vpro-ecache-subgrp" {
  name       = "vpro-ecache-subgrp"
  subnet_ids = [module.VPC.private_subnets[0], module.VPC.private_subnets[1], module.VPC.private_subnets[2]]
  tags = {
    Name = "Subnet group for ECACHE"
  }
}

resource "aws_db_instance" "vpro-rds" {
  allocated_storage = 20
  storage_type      = "gp2"
  engine            = "mysql"
  engine_version    = "8.0.33"
  instance_class    = "db.t2.micro"
  #   name = var.dbname
  db_name  = var.dbname
  username = var.dbuser
  password = var.dbpass
  #   parameter_group_name   = "default.mysql5.7"
  multi_az               = "false"
  publicly_accessible    = "false"
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.vpro-rds-subgrp.name
  vpc_security_group_ids = [aws_security_group.vpro-backend-sg.id]
}

resource "aws_elasticache_cluster" "vpro-cache" {
  cluster_id           = "vpro-cache"
  engine               = "memcached"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.memcached1.6"
  port                 = 11211
  security_group_ids   = [aws_security_group.vpro-backend-sg.id]
  subnet_group_name    = aws_elasticache_subnet_group.vpro-ecache-subgrp.name
}

resource "aws_mq_broker" "vpro-rmq" {
  broker_name        = "vpro-rmq"
  engine_type        = "ActiveMQ"
  engine_version     = "5.17.6"
  host_instance_type = "mq.t2.micro"
  security_groups    = [aws_security_group.vpro-backend-sg.id]
  subnet_ids         = [module.VPC.private_subnets[0]]

  user {
    username = var.rmquser
    password = var.rmqpass
  }
}