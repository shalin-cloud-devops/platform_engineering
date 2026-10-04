module "liquibase_host" {
  source        = "terraform-aws-modules/ec2-instance/aws"
  name          = "LiquiBase_Host"
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.small"
  monitoring    = true

  subnet_id = split(",", data.aws_ssm_parameter.mutual_fund_app_private_subnets.value)[0]

  vpc_security_group_ids      = [data.aws_ssm_parameter.db_clients_sg_id.value, aws_security_group.liquibase_sg.id]
  associate_public_ip_address = false
  iam_instance_profile        = data.aws_ssm_parameter.db_instance_profile.value
  user_data                   = file("${path.module}/scripts/db_install.sh")

}
