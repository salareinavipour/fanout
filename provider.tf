provider "aws" {
  access_key                  = "mock_access_key"
  region                      = "eu-central-1"
  secret_key                  = "mock_secret_key"

    endpoints {
    iam            = "http://localhost:4566"
    sns            = "http://localhost:4566"
    sqs            = "http://localhost:4566"
    sts            = "http://localhost:4566"
  }
}