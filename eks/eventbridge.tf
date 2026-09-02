resource "aws_cloudwatch_event_rule" "eks_karpenter_health_event" {
  name        = "eks-karpenter-health-rule"
  description = "Rule to capture scheduled Events"
  event_pattern = jsonencode({
    "source" : ["aws.health"],
    "detail-type" : ["AWS Health Event"]

  })
}

resource "aws_cloudwatch_event_rule" "eks_karpenter_spot_interruption" {
  name        = "eks-karpenter-spot-interruption-rule"
  description = "Rule to capture EC2 Spot Instance Interruption Warnings"

  event_pattern = jsonencode({
    "source"      = ["aws.ec2"]
    "detail-type" = ["EC2 Spot Instance Interruption Warning"]
  })
}

resource "aws_cloudwatch_event_rule" "eks_karpenter_rebalance" {
  name        = "eks-karpenter-rebalance-rule"
  description = "Rule to capture EC2 Instance Rebalance Recommendations"

  event_pattern = jsonencode({
    "source"      = ["aws.ec2"]
    "detail-type" = ["EC2 Instance Rebalance Recommendation"]
  })
}

resource "aws_cloudwatch_event_rule" "eks_karpenter_state_change" {
  name        = "eks-karpenter-state-change-rule"
  description = "Rule to capture EC2 Instance State-change Notifications"

  event_pattern = jsonencode({
    "source"      = ["aws.ec2"]
    "detail-type" = ["EC2 Instance State-change Notification"]
  })
}

