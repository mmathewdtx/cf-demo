# S3 bucket “Images” 
module "s3_images_bucket" {
  source = "github.com/Coalfire-CF/terraform-aws-s3"

  name                                 = "images-mtmathew"
  enable_lifecycle_configuration_rules = false # Documented Issue #9 in repo not supporting prefix. Creating seperate rule(s) via resource
  #   lifecycle_configuration_rules = [
  #   {

  #     "enable_glacier_transition": true,
  #     "prefix": "memes", 
  #     "enabled": true,
  #     "glacier_transition_days": 90,
  #     "id": "glacier90"
  #   }
  # ]
  enable_kms                    = true
  enable_server_side_encryption = true
  block_public_policy           = true
  block_public_acls             = true

}

# Memes folder in Images Bucket
resource "aws_s3_object" "images_memes" {
  bucket = module.s3_images_bucket.id
  key    = "Memes/"
}

# Lifecycle Config to move objects in Memes folder that are older than 90 days to glacier.
resource "aws_s3_bucket_lifecycle_configuration" "images_glacier90" {
  bucket = module.s3_images_bucket.id

  rule {
    id = "glacier90"

    filter {
      prefix = "Memes/"
    }

    transition {
      days          = 90
      storage_class = "GLACIER"
    }

    status = "Enabled"
  }
}

# S3 bucket “Logs”
module "s3_logs_bucket" {
  source = "github.com/Coalfire-CF/terraform-aws-s3"

  name                                 = "logs-mtmathew"
  enable_lifecycle_configuration_rules = false # Documented Issue #9 in repo not supporting prefix. Creating seperate rule(s) via resource
  enable_kms                           = true
  enable_server_side_encryption        = true
  block_public_policy                  = true
  block_public_acls                    = true
}

# Active folder in Images Bucket
resource "aws_s3_object" "logs_active" {
  bucket = module.s3_logs_bucket.id
  key    = "Active/"
}

# Inactive folder in Images Bucket
resource "aws_s3_object" "logs_inactive" {
  bucket = module.s3_logs_bucket.id
  key    = "Inactive/"
}

# Lifecycle Config to move objects in Active folder to glacier after 90 days. And Expire objects in the Logs folder after 90 days.
resource "aws_s3_bucket_lifecycle_configuration" "logs_glacier90_expire90" {
  bucket = module.s3_logs_bucket.id

  rule {
    id     = "glacier90"
    status = "Enabled"

    filter {
      prefix = "Active/"
    }

    transition {
      days          = 90
      storage_class = "GLACIER"
    }
  }

  rule {
    id     = "expire90"
    status = "Enabled"


    filter {
      prefix = "Inactive/"
    }

    expiration {
      days = 90
    }
  }
}