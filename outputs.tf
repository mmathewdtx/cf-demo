# VPC 
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets
}

output "private_subnets_cidr_blocks" {
  description = "List of cidr_blocks of private subnets"
  value       = module.vpc.private_subnets_cidr_blocks
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}

output "public_subnets_cidr_blocks" {
  description = "List of cidr_blocks of public subnets"
  value       = module.vpc.public_subnets_cidr_blocks
}

output "nat_public_ips" {
  description = "List of public Elastic IPs created for AWS NAT Gateway"
  value       = module.vpc.nat_public_ips
}

output "natgw_ids" {
  description = "List of NAT Gateway IDs"
  value       = module.vpc.natgw_ids
}

output "igw_id" {
  description = "The ID of the Internet Gateway"
  value       = module.vpc.igw_id
}

output "vpc_endpoint_s3_id" {
  description = "The ID of VPC endpoint for S3"
  value       = module.vpc.vpc_endpoint_s3_id
}


# EC2 
output "instance_id" {
  description = "The AWS Instance id created"
  value       = module.ec2.instance_id
}

output "ec2_security_group_id" {
  description = "The AWS security group id created"
  value       = module.ec2.sg_id
}

output "ec2_role_name" {
  description = "The AWS IAM role name created"
  value       = module.ec2.iam_role_name
}

output "ec2_role_arn" {
  description = "The AWS IAM role arn created"
  value       = module.ec2.iam_role_arn
}

output "ec2_iam_profile" {
  description = "The AWS IAM profile name created"
  value       = module.ec2.iam_profile
}

# ASG
output "asg_name" {
  description = "The autoscaling group name"
  value       = module.asg.autoscaling_group_name
}

output "asg_arn" {
  description = "The ARN for this AutoScaling Group"
  value       = module.asg.autoscaling_group_arn
}

output "asg_id" {
  description = "The autoscaling group id"
  value       = module.asg.autoscaling_group_id
}

output "asg_min" {
  description = "The minimum size of the autoscale group"
  value       = module.asg.autoscaling_group_min_size
}

output "asg_max" {
  description = "The maximum size of the autoscale group"
  value       = module.asg.autoscaling_group_max_size
}

output "asg_role_name" {
  description = "The name of the IAM role"
  value       = module.asg.iam_role_name
}

output "asg_launch_template" {
  description = "The name of the launch template"
  value       = module.asg.launch_template_name
}

output "asg_security_group_id" {
  description = "The name of the launch template"
  value       = module.asg_sg.id
}

# ALB
output "alb_id" {
  description = "The ID and ARN of the load balancer"
  value       = module.alb.id
}

output "alb_listeners" {
  description = "Map of listeners created and their attributes"
  value       = module.alb.listeners
}

output "alb_listener_rules" {
  description = "Map of listeners rules created and their attributes"
  value       = module.alb.listener_rules
}

output "alb_security_group_id" {
  description = "ID of the security group"
  value       = module.alb.security_group_id
}

output "alb_target_group" {
  description = "Map of target groups created and their attributes"
  value       = module.alb.target_groups
}


# S3 
output "s3_images_id" {
  description = "The ID of the Images s3 bucket."
  value       = module.s3_images_bucket.id
}

output "s3_logs_id" {
  description = "The ID of the Logs s3 bucket."
  value       = module.s3_logs_bucket.id
}

