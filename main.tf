resource "aws_sns_topic" "topic" {
    name = "${var.topic_name}"
}

resource "aws_sqs_queue" "queue" {
    for_each = toset("${var.queue_name}")
    name = each.key
    receive_wait_time_seconds  = 20
    message_retention_seconds  = 18400
}

resource "aws_sns_topic_subscription" "subscription" {
  for_each = toset("${var.queue_name}")
  protocol             = "sqs"
  raw_message_delivery = true
  topic_arn            = aws_sns_topic.topic.arn
  endpoint             = aws_sqs_queue.queue[each.key].arn
}

resource "aws_sqs_queue_policy" "sqs_policy" {
  for_each = toset("${var.queue_name}")
  queue_url = aws_sqs_queue.queue[each.key].id
  policy    = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "sns.amazonaws.com"
      },
      "Action": [
        "sqs:SendMessage"
      ],
      "Resource": [
        "${aws_sqs_queue.queue[each.key].arn}"
      ],
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${aws_sns_topic.topic.arn}"
        }
      }
    }
  ]
}
EOF
}