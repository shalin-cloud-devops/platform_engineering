module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name   = "mutual_fund_vpc"
  cidr   = "10.0.0.0/16"

  azs             = ["${var.aws_region}a", "${var.aws_region}b", "${var.aws_region}c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway      = true
  enable_vpn_gateway      = false
  single_nat_gateway      = true
  map_public_ip_on_launch = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }

}

resource "aws_ssm_parameter" "vpc_id" {
  name  = "/mutual_fund_app/vpc_id"
  type  = "String"
  value = module.vpc.vpc_id

}

resource "aws_ssm_parameter" "private_subnets" {
  name  = "/mutual_fund_app/private_subnets"
  type  = "StringList"
  value = join(",", module.vpc.private_subnets)

}

resource "aws_ssm_parameter" "public_subnets" {
  name  = "/mutual_fund_app/public_subnets"
  type  = "StringList"
  value = join(",", module.vpc.public_subnets)

}
