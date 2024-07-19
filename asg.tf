# Security Group allowing 443 from ALB
module "asg_sg" {
  source = "github.com/Coalfire-CF/terraform-aws-securitygroup"

  name = "asg-sg"

  vpc_id = module.vpc.vpc_id

  ingress_rules = {
    "allow_https" = {
      ip_protocol                  = "tcp"
      from_port                    = "443"
      to_port                      = "443"
      referenced_security_group_id = module.alb.security_group_id
    }
  }

  egress_rules = {
    "allow_all_egress" = {
      ip_protocol = "-1"
      cidr_ipv4   = "0.0.0.0/0"
      description = "Allow all egress"
    }
  }
}

# EC2 ASG for Apache Web Servers
module "asg" {
  source = "terraform-aws-modules/autoscaling/aws"

  # Autoscaling group
  name = var.asg_name

  min_size                  = 2
  max_size                  = 6
  wait_for_capacity_timeout = 0
  health_check_type         = "EC2"
  vpc_zone_identifier       = [module.vpc.private_subnets.demo-vpc-private-us-east-1a, module.vpc.private_subnets.demo-vpc-private-us-east-1b]
  security_groups           = [module.asg_sg.id]

  #ALB Settings
  create_traffic_source_attachment = true
  traffic_source_identifier        = module.alb.target_groups["web_asg"].arn
  traffic_source_type              = "elbv2"


  # Launch template
  launch_template_name        = "web-launch-template"
  launch_template_description = "Apache Web Server"
  update_default_version      = true

  image_id          = "ami-0583d8c7a9c35822c"
  instance_type     = "t2.micro"
  user_data         = base64encode(local.apache_userdata)
  enable_monitoring = true

  # IAM role & instance profile
  create_iam_instance_profile = true
  iam_role_name               = "web-role"
  iam_role_path               = "/ec2/"
  iam_role_description        = "Web Ec2 Role"
  iam_role_tags = {
    CustomIamRole = "Yes"
  }
  iam_role_policies = {
    read_images_policy = aws_iam_policy.read_images_policy.arn
    write_logs_policy  = aws_iam_policy.write_logs_policy.arn
  }

  block_device_mappings = [
    {
      # Root volume
      device_name = "/dev/xvda"
      no_device   = 0
      ebs = {
        delete_on_termination = true
        encrypted             = true
        volume_size           = 20
        volume_type           = "gp2"
      }
    }
  ]


}