

# cf-demo

This repository contains Terraform configurations to set up a comprehensive AWS architecture. The setup includes an application load balancer, auto-scaling groups, EC2 instances, KMS encryption, S3 buckets, VPC, subnets, and associated policies.

  # Resources

 - 1 VPC (`10.1.0.0/16`)
	 -  4 Subnets (spread evenly across two availability zones)
		 -  Sub1 (`10.1.0.0/24`) - Public
		  - Sub2 (`10.1.1.0/24`) - Public
		  -  Sub3 (`10.1.2.0/24`) - Private
		  -  Sub4 (`10.1.3.0/24`) - Private

 - 1 EC2 instance running Red Hat Linux in Subnet 2
	  - 20 GB storage
	  -  t2.micro instance type

 - 1 Auto Scaling Group (ASG) with instances in Subnets 3 and 4
	 -  Red Hat Linux instances
	 - 20 GB storage
	 - Apache web server (httpd) installation script
	 -  IAM role to read from "images" bucket
	 -  Minimum 2, maximum 6 hosts
	 -  t2.micro instance type

 - 1 Application Load Balancer (ALB)
	 -  Listens on port 80 (HTTP)
	 - Forwards traffic to ASG on port 443

 - Security groups for necessary traffic

 - IAM roles for log writing and S3 bucket access
 
 - 1 S3 bucket: "Images" with an "archive" folder and a "memes" folder (objects older than 90 days moved to Glacier)

 - 1 S3 bucket: "Logs" with "active" and "inactive" folders (objects older than 90 days in "active" moved to Glacier, objects older than 90 days in "inactive" deleted)

 # Architecture Diagram 
 ![Architecture Diagram](https://github.com/mmathewdtx/cf-demo/blob/main/Architecture%20Diagram.jpg?raw=true)
  

# Prerequisites

- Terraform installed.
- AWS credentials configured. Refer to the [AWS documentation](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html) for setup instructions.
- An existing key pair in your AWS account  

# Usage

 **Clone the repository:**

```
git clone https://github.com/mmathewdtx/cf-demo.git &&
cd cf-demo/
```

 **Initialize the Terraform configuration:**

```
terraform init
```

**Review and modify variable values as needed:**

Edit the `vars.auto.tfvars` file to adjust default values or override them through the command line.

 **Plan the infrastructure changes:**

```
terraform plan
```

 **Apply the infrastructure changes:**

```
terraform apply 
```

Confirm the apply action when prompted.


# Outputs


| Name                        | Description                                        |
|-----------------------------|----------------------------------------------------|
| `vpc_id`                    | The ID of the VPC                                 |
| `vpc_cidr_block`            | The CIDR block of the VPC                         |
| `private_subnets`           | List of IDs of private subnets                    |
| `private_subnets_cidr_blocks` | List of CIDR blocks of private subnets           |
| `public_subnets`            | List of IDs of public subnets                     |
| `public_subnets_cidr_blocks` | List of CIDR blocks of public subnets            |
| `nat_public_ips`            | List of public Elastic IPs created for AWS NAT Gateway |
| `natgw_ids`                 | List of NAT Gateway IDs                           |
| `igw_id`                    | The ID of the Internet Gateway                    |
| `vpc_endpoint_s3_id`        | The ID of VPC endpoint for S3                     |
| `instance_id`               | The AWS Instance ID created                       |
| `ec2_security_group_id`     | The AWS security group ID created                 |
| `ec2_role_name`             | The AWS IAM role name created                     |
| `ec2_role_arn`              | The AWS IAM role ARN created                      |
| `ec2_iam_profile`           | The AWS IAM profile name created                  |
| `asg_name`                  | The autoscaling group name                        |
| `asg_arn`                   | The ARN for this AutoScaling Group                |
| `asg_id`                    | The autoscaling group ID                          |
| `asg_min`                   | The minimum size of the autoscale group           |
| `asg_max`                   | The maximum size of the autoscale group           |
| `asg_role_name`             | The name of the IAM role                          |
| `asg_launch_template`       | The name of the launch template                   |
| `asg_security_group_id`     | The ID of the security group associated with the ASG |
| `alb_id`                    | The ID and ARN of the load balancer               |
| `alb_listeners`             | Map of listeners created and their attributes     |
| `alb_listener_rules`        | Map of listener rules created and their attributes |
| `alb_security_group_id`     | ID of the security group associated with the ALB  |
| `alb_target_group`          | Map of target groups created and their attributes |
| `s3_images_id`              | The ID of the Images S3 bucket                    |
| `s3_logs_id`                | The ID of the Logs S3 bucket                      |

# Cleanup

To destroy the infrastructure created by this configuration:

`terraform destroy`
