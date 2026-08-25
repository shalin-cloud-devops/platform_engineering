data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}


data "aws_ssm_parameter" "mutual_fund_app_vpc_id" {
  name = "/mutual_fund_app/vpc_id"

}

data "aws_ssm_parameter" "mutual_fund_app_private_subnets" {
  name  = "/mutual_fund_app/private_subnets"
  value = split(data.aws_ssm_parameter.mutual_fund_app_private_subnets.value, ",")

}

data "aws_ssm_parameter" "mutual_fund_app_public_subnets" {
  name  = "/mutual_fund_app/public_subnets"
  value = split(data.aws_ssm_parameter.mutual_fund_app_public_subnets.value, ",")

}
