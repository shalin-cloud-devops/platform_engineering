resource "aws_eks_access_entry" "eks_access_entry" {
  cluster_name      = var.cluster_name
  principal_arn     = aws_iam_role.fund_fetch_role.arn
  kubernetes_groups = ["fund-fetchers-svc"]
  type              = "STANDARD"
}
