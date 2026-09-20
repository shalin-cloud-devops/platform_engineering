#checkov:skip=CKV_AWS_393:GitHub Actions OIDC is correct, CHEKOV is yet to update the CLI verison from - 3.3.19
resource "aws_iam_role" "mf_app_ecr_role" {
  name = "mf_app_ecr_role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "arn:aws:iam::514005485562:oidc-provider/token.actions.githubusercontent.com"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "token.actions.githubusercontent.com:aud" : "sts.amazonaws.com"
            "token.actions.githubusercontent.com:sub" : [
              "repo:shalin-cloud-devops@219416972/mf_fin_app@1369936654:ref:refs/heads/main",
              "repo:shalin-cloud-devops@219416972/mf_fin_app@1369936654:environment:production"
            ]

          },

        }
      }
    ]
  })
}
resource "aws_iam_role_policy" "mf_app_ecr_policy" {
  name = "mf_app_ecr_policy"
  role = aws_iam_role.mf_app_ecr_role.id

  policy = jsonencode({
    "Version" : "2012-10-17",

    "Statement" : [
      {
        "Sid" : "EcrLogin",
        "Effect" : "Allow",
        "Action" : [
          "ecr:GetAuthorizationToken"
        ],
        "Resource" : "*"
      },

      {
        "Sid" : "EcrPush",
        "Effect" : "Allow",
        "Action" : [
          "ecr:BatchCheckLayerAvailability",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload",
          "ecr:PutImage"
        ],
        "Resource" : [
          "arn:aws:ecr:us-east-1:514005485562:repository/fund-fetcher",
          "arn:aws:ecr:us-east-1:514005485562:repository/db-writer",
          "arn:aws:ecr:us-east-1:514005485562:repository/overlap-checker"
        ]
      },

      {
        "Sid" : "EcrPull",
        "Effect" : "Allow",
        "Action" : [
          "ecr:BatchGetImage",
          "ecr:GetDownloadUrlForLayer"
        ],
        "Resource" : [
          "arn:aws:ecr:us-east-1:514005485562:repository/fund-fetcher",
          "arn:aws:ecr:us-east-1:514005485562:repository/db-writer",
          "arn:aws:ecr:us-east-1:514005485562:repository/overlap-checker"
        ]
      }
    ]
  })
}
