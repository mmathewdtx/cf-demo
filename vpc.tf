# VPC 10.1.0/16 
module "vpc" {
  source = "github.com/Coalfire-CF/terraform-aws-vpc-nfw"

  name = "${var.resource_prefix}-vpc"

  cidr = var.vpc_cidr

  azs = [data.aws_availability_zones.available.names[0], data.aws_availability_zones.available.names[1]]

  private_subnets = local.private_subnets
  public_subnets  = local.public_subnets
  private_subnet_tags = {
    "0" = "Private"
    "1" = "Private"
  }

  public_subnet_suffix = "dmz"

  single_nat_gateway              = false
  enable_nat_gateway              = true
  one_nat_gateway_per_az          = true
  enable_dns_hostnames            = true
  flow_log_destination_type       = "cloud-watch-logs"
  cloudwatch_log_group_kms_key_id = aws_kms_key.cloudwatch_key.arn
  enable_s3_endpoint              = true

}