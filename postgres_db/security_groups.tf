resource "aws_security_group" "db_clients" {
  name        = "db_clients"
  description = "Security group for clients to access the database"
  vpc_id      = data.aws_ssm_parameter.mutual_fund_app_vpc_id.value

}


resource "aws_security_group" "db_security_group" {
  name        = "db_security_group"
  description = "Security group for the database"
  vpc_id      = data.aws_ssm_parameter.mutual_fund_app_vpc_id.value

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.db_clients.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

}
