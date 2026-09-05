resource "aws_iam_role" "csi_driver_role" {
  name = "csi-driver-role"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : module.eks.oidc_provider_arn
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {

            "${module.eks.oidc_provider}:sub" : "system:serviceaccount:kube-system:ebs-csi-controller-sa",
            "${module.eks.oidc_provider}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
  })


  tags = {
    Service = "EBS CSI Driver"
    Team    = "Platform Engineering - Dev"
  }

}

resource "aws_iam_role_policy_attachment" "csi_driver_policy_attachment" {
  role       = aws_iam_role.csi_driver_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}

resource "aws_eks_addon" "csi_driver" {
  cluster_name  = module.eks.cluster_name
  addon_name    = "aws-ebs-csi-driver"
  addon_version = "v1.64.0-eksbuild.1"

  service_account_role_arn = aws_iam_role.csi_driver_role.arn
}
