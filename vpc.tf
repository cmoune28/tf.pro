module "VPC" {
  source = "terraform-aws-modules/vpc/aws"

  name            = var.VPC_name
  cidr            = var.VPC_CIDR
  azs             = [var.Zone1, var.Zone2, var.Zone3]
  private_subnets = [var.Priv_SN_1_CIDR, var.Priv_SN_2_CIDR, var.Priv_SN_3_CIDR]
  public_subnets  = [var.Pub_SN_1_CIDR, var.Pub_SN_2_CIDR, var.Pub_SN_3_CIDR]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Terraform   = "true"
    Environment = "Prod"
  }

  vpc_tags = {
    Name = var.VPC_name
  }
}