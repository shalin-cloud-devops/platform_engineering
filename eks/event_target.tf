
resource "aws_cloudwatch_event_target" "eks_karpenter_health_event_target" {
  rule      = aws_cloudwatch_event_rule.eks_karpenter_health_event.name
  target_id = "eks-karpenter-health-event-target"
  arn       = aws_sqs_queue.karpenter_interruption_queue.arn
}

resource "aws_cloudwatch_event_target" "eks_karpenter_spot_interruption_target" {
  rule      = aws_cloudwatch_event_rule.eks_karpenter_spot_interruption.name
  target_id = "eks-karpenter-spot-interruption-target"
  arn       = aws_sqs_queue.karpenter_interruption_queue.arn
}

resource "aws_cloudwatch_event_target" "eks_karpenter_rebalance_target" {
  rule      = aws_cloudwatch_event_rule.eks_karpenter_rebalance.name
  target_id = "eks-karpenter-rebalance-target"
  arn       = aws_sqs_queue.karpenter_interruption_queue.arn
}

resource "aws_cloudwatch_event_target" "eks_karpenter_state_change_target" {
  rule      = aws_cloudwatch_event_rule.eks_karpenter_state_change.name
  target_id = "eks-karpenter-state-change-target"
  arn       = aws_sqs_queue.karpenter_interruption_queue.arn
}
