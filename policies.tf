# IAM Policy for reading from the "images" bucket
resource "aws_iam_policy" "read_images_policy" {
  name        = "ReadImagesPolicy"
  description = "Policy to allow read access to the images bucket"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["s3:GetObject"]
        Resource = ["arn:aws:s3:::${module.s3_images_bucket.id}/*"]
      }
    ]
  })
}

# IAM Policy for writing to the "logs" bucket
resource "aws_iam_policy" "write_logs_policy" {
  name        = "WriteLogsPolicy"
  description = "Policy to allow write access to the logs bucket"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["s3:PutObject"]
        Resource = ["arn:aws:s3:::${module.s3_logs_bucket.id}/*"]
      }
    ]
  })
}

