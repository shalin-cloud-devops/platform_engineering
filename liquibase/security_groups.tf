resource "aws_security_group" "liquibase_sg" {
  name        = "liquibase_sg"
  description = "Security group for LiquiBase host"
  vpc_id      = data.aws_ssm_parameter.mutual_fund_app_vpc_id.value

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

}
