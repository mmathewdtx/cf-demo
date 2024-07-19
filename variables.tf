variable "resource_prefix" {
  description = "A prefix that should be attached to the names of resources"
  type        = string
  default     = "demo"
}

variable "aws_region" {
  description = "The AWS region to create resources in."
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR range of the VPC"
  type        = string
}

variable "ec2_name" {
  description = "Name of Ec2 Instance"
  type        = string
}

variable "ssh_ingress_ip" {
  description = "CIDR range for SSH admins"
  type        = string
}

variable "ec2_key_pair" {
  description = "Keypair Name to SSH into EC2"
  type        = string
}

variable "alb_name" {
  description = "Name of ALB for ASG Targets"
  type        = string
}

variable "asg_name" {
  description = "Name of ASG"
  type        = string
}
