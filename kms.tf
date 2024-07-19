resource "aws_kms_key" "cloudwatch_key" {
  description         = "cloudwatch key"
  policy              = data.aws_iam_policy_document.cloudwatch_key.json
  enable_key_rotation = true
}

resource "aws_kms_alias" "cloudwatch_key_alias" {
  name          = "alias/cloudwatch-cmk"
  target_key_id = aws_kms_key.cloudwatch_key.key_id
}

data "aws_iam_policy_document" "cloudwatch_key" {

  statement {
    sid    = "Allow use of the key"
    effect = "Allow"
    actions = [
      "kms:*"
    ]
    principals {
      identifiers = ["arn:${local.partition}:iam::${local.account_id}:root"]
      type        = "AWS"
    }
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey",
    ]
    resources = [
    "*"]

    principals {
      type = "Service"
      identifiers = [
      "delivery.logs.amazonaws.com"]
    }
  }

  statement {
    effect = "Allow"
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey",
    ]
    resources = [
    "*"]

    principals {
      type = "Service"
      identifiers = [
      "firehose.amazonaws.com"]
    }
  }

  statement {
    effect = "Allow"
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey",
    ]
    resources = [
    "*"]

    principals {
      type = "Service"
      identifiers = [
      "logs.${var.aws_region}.amazonaws.com"]
    }
  }


  statement {
    sid    = "Allow attachment of persistent resources"
    effect = "Allow"
    actions = [
      "kms:CreateGrant",
      "kms:ListGrants",
      "kms:RevokeGrant"
    ]
    principals {
      identifiers = ["arn:${local.partition}:iam::${local.account_id}:root"]
      type        = "AWS"
    }
    resources = ["*"]
    condition {
      test     = "Bool"
      variable = "kms:GrantIsForAWSResource"
      values   = [true]
    }
  }
}

resource "aws_kms_key" "ebs_key" {
  description         = "ebs key for ec2-module"
  policy              = data.aws_iam_policy_document.ebs_key.json
  enable_key_rotation = true
}

data "aws_iam_policy_document" "ebs_key" {
  statement {
    effect    = "Allow"
    actions   = ["kms:*"]
    resources = ["*"]
    principals {
      type = "AWS"
      identifiers = [
        "arn:${local.partition}:iam::${data.aws_caller_identity.current.account_id}:root"
      ]
    }
  }
}
