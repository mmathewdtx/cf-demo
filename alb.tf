# ALB For Apache Web Instances in ASG
module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 9.0"

  name                       = var.alb_name
  enable_deletion_protection = false

  vpc_id  = module.vpc.vpc_id
  subnets = [module.vpc.public_subnets.demo-vpc-dmz-us-east-1a, module.vpc.public_subnets.demo-vpc-dmz-us-east-1b]

  # Allow 80 from the internet 
  security_group_ingress_rules = {
    all_http = {
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }
  security_group_egress_rules = {
    all = {
      ip_protocol                  = "-1"
      referenced_security_group_id = module.asg_sg.id
    }
  }

  # Listen on 80
  listeners = {
    http = {
      port     = 80
      protocol = "HTTP"
      forward = {
        target_group_key = "web_asg"
      }
    }
  }

  # Create Target Group for ASG
  target_groups = {
    web_asg = {
      name_prefix                       = "web-tg"
      protocol                          = "HTTPS"
      port                              = 443
      target_type                       = "instance"
      deregistration_delay              = 5
      load_balancing_cross_zone_enabled = true
      create_attachment                 = false
    }
  }

}