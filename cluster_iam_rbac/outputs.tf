output "iam_role_name" {
  value = aws_iam_role.fund_fetch_role.name

}

output "iam_role_arn" {
  value = aws_iam_role.fund_fetch_role.arn

}
