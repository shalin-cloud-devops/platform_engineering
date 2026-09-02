resource "aws_sqs_queue" "karpenter_interruption_queue" {
  name                       = "karpenter-interruption-queue"
  visibility_timeout_seconds = 30
  message_retention_seconds  = 300

}

resource "aws_sqs_queue_policy" "karpenter_interruption_queue_policy" {
  queue_url = aws_sqs_queue.karpenter_interruption_queue.url

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "events.amazonaws.com"
        }
        Action   = "sqs:SendMessage"
        Resource = aws_sqs_queue.karpenter_interruption_queue.arn
      }
    ]
  })

}
