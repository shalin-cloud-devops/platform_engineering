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
