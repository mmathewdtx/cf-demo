
# # EC2 instance running Red Hat Linux in subnet sub2
# module "ec2" {
#   source = "github.com/Coalfire-CF/terraform-aws-ec2"

#   name = var.ec2_name

#   ami               = "ami-0583d8c7a9c35822c"
#   ec2_instance_type = "t2.micro"
#   iam_policies      = [aws_iam_policy.write_logs_policy.arn]

#   vpc_id              = module.vpc.vpc_id
#   subnet_ids          = [module.vpc.public_subnets.demo-vpc-dmz-us-east-1b]
#   associate_public_ip = true

#   ec2_key_pair = "mtmathew"

#   ebs_kms_key_arn  = aws_kms_key.ebs_key.arn
#   root_volume_size = "20"

# ingress_rules = {
#     "ssh" = {
#       ip_protocol = "tcp"
#       from_port   = "22"
#       to_port     = "22"
#       cidr_ipv4   = var.ssh_ingress_ip
#       description = "RDP"
#     }
#   }

#   egress_rules = {
#     "allow_all_egress" = {
#       ip_protocol = "-1"
#       cidr_ipv4   = "0.0.0.0/0"
#       description = "Allow all egress"
#     }
#   }

#   global_tags = {}
# }



// Legacy Module

# EC2 instance running Red Hat Linux in subnet sub2 with 20gb storage 
module "ec2" {
  source = "github.com/Coalfire-CF/terraform-aws-ec2?ref=v1.0.7"
  name   = var.ec2_name

  ami               = "ami-0583d8c7a9c35822c"
  ec2_instance_type = "t2.micro"
  iam_policies      = [aws_iam_policy.write_logs_policy.arn]


  vpc_id              = module.vpc.vpc_id
  subnet_ids          = [module.vpc.public_subnets.demo-vpc-dmz-us-east-1b]
  associate_public_ip = true

  ec2_key_pair    = var.ec2_key_pair
  ebs_kms_key_arn = aws_kms_key.ebs_key.arn

  # Storage
  root_volume_size = "20"

  # SG to allow SSH from Admin CIDRs
  ingress_rules = [
    {
      protocol    = "tcp"
      from_port   = "22"
      to_port     = "22"
      cidr_blocks = [var.ssh_ingress_ip]
  }]

  egress_rules = [{
    protocol    = "-1"
    from_port   = "0"
    to_port     = "0"
    cidr_blocks = ["0.0.0.0/0"]
  }]


  global_tags = {}
}
