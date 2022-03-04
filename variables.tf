variable "topic_name" {
  type        = string
  default = "sample-topic-1"
  description = "The name of the SNS topic."
}

variable "queue_name" {
  type    = list(string)
  default = ["sample-queue-1", "sample-queue-2"]
  description = "The name of the SQS queue."
}