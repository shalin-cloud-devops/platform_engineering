resource "aws_iam_role" "fund_fetch_role" {
  name = "fund_fetch_role"


  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          AWS = "arn:aws:iam::514005485562:root"
        }
      },
    ]
  })

  tags = {
    Service = "Fund Fetching Service"
    Team    = "Mutual Fund App - Dev"
  }
}
