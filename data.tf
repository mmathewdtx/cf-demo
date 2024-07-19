data "aws_partition" "current" {}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_caller_identity" "current" {
  provider = aws.mgmt
}