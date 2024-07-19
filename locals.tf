locals {
  account_id      = data.aws_caller_identity.current.account_id
  partition       = data.aws_partition.current.partition
  public_subnets  = [for k, v in module.subnets.network_cidr_blocks : v if length(regexall(".*public.*", k)) > 0]
  private_subnets = [for k, v in module.subnets.network_cidr_blocks : v if(length(regexall(".*priv.*", k)) > 0 || length(regexall(".*compute.*", k)) > 0)]
  apache_userdata = <<-EOT
    #!/bin/bash
    # Update the system
    yum update -y
    # Install Apache
    yum install httpd -y
    # Start Apache service
    systemctl start httpd
    # Enable Apache to start on boot
    systemctl enable httpd
  EOT
}
