resource "aws_iam_role" "db_ssm_role" {
  name = "db_ssm_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

}

resource "aws_iam_role_policy_attachment" "attach_ssm_policy_role" {
  role       = aws_iam_role.db_ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"

}

resource "aws_iam_instance_profile" "db_ssm_instance_profile" {
  name = "db_ssm_instance_profile"
  role = aws_iam_role.db_ssm_role.name
}

module "db_host" {
  source        = "terraform-aws-modules/ec2-instance/aws"
  name          = "DB_Host"
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.large"
  monitoring    = true

  subnet_id                   = split(",", data.aws_ssm_parameter.mutual_fund_app_private_subnets.value)[0]
  vpc_security_group_ids      = [aws_security_group.db_security_group.id]
  associate_public_ip_address = false
  iam_instance_profile        = aws_iam_instance_profile.db_ssm_instance_profile.name
  user_data                   = file("${path.module}/scripts/db_install.sh")

}
