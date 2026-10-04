data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_ssm_parameter" "mutual_fund_app_vpc_id" {
  name = "/mutual_fund_app/vpc_id"

}

data "aws_ssm_parameter" "mutual_fund_app_private_subnets" {
  name = "/mutual_fund_app/private_subnets"

}

data "aws_ssm_parameter" "db_clients_sg_id" {
  name = "/mutual_fund_app/security_group/db_clients"

}

data "aws_ssm_parameter" "db_instance_profile" {
  name = "/mutual_fund_app/iam_instance_profile/db_ssm_instance_profile"

}
