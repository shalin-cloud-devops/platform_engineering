resource "aws_ssm_parameter" "db_clients_sg_id" {
  name  = "/mutual_fund_app/security_group/db_clients"
  type  = "String"
  value = aws_security_group.db_clients.id
}

resource "aws_ssm_parameter" "db_instance_profile" {
  name  = "/mutual_fund_app/iam_instance_profile/db_ssm_instance_profile"
  type  = "String"
  value = aws_iam_instance_profile.db_ssm_instance_profile.name
}

