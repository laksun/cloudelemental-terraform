# -------------------------------------Data resources------------------------------
data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_partition" "current" {}


locals {
  app_name                               = "${var.oracledb_name}-${var.env}-yla"
  oracle_ServerAccessSecurity_group_name = "${var.oracledb_name}-${var.env}-oracle-server-access-security-group"
  oracle_cluster_security_group_name     = "${var.oracledb_name}-cluster-${var.env}-oracle-security-group"
  oracle_security_group_name             = "${var.oracledb_name}-${var.env}-oracle-security-group"
  oracleservers_security_group_name      = "${var.oracledb_name}-${var.env}-oracle-servers-security-group"
  oracle_skyappliance_group_name         = "${var.oracledb_name}-${var.env}-oracle-skyappliance-security-group"
  ports                                  = var.ports
  subnet_id                              = sort(data.aws_subnet_ids.private_subnets.ids)[0]
  #### Oracle roles
  oracle_tags = {
    "BlueprintSource"  = "it.ec2.cloudformation.oracle"
    "BlueprintVersion" = var.BlueprintVersion

  }
}

# ---------------------------------Cloudformation Exports---------------------------------
data "aws_cloudformation_export" "vpc_id" {
  name = "${var.product}-vpc-id"
}

data "aws_subnet_ids" "private_subnets" {
  vpc_id = data.aws_cloudformation_export.vpc_id.value

  tags = {
    Name = "${var.product}-*-prv*"

  }
}

#---------------------------------Oracle Policies-----------------------------------------
data "aws_iam_policy_document" "IdentityFunctionExecution_Trust_Policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = [
        "lambda.amazonaws.com"
      ]
    }

    effect = "Allow"
  }
}

data "aws_iam_policy_document" "IdentityFunctionExecution-policy" {
  statement {
    actions = [
      "cloudformation:DescribeStacks"
    ]
    resources = ["arn:aws:cloudformation:*:*:*"]
    effect    = "Allow"
  }
}

data "aws_iam_policy_document" "OracleInstanceRole_trust_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = [
        "ec2.amazonaws.com", "ssm.amazonaws.com"
      ]
    }

    effect = "Allow"
  }
}
#-----

data "aws_iam_policy_document" "oracle-ec2-s3-policy-1" {
  statement {
    actions = [
      "s3:ListBucket"
    ]
    resources = ["arn:aws:s3:::${var.QSS3BucketName}-${data.aws_region.current.name}", aws_s3_bucket.oracle-load-files.arn]
    effect    = "Allow"
  }
}

data "aws_iam_policy_document" "oracle-ec2-s3-policy-2" {
  statement {
    actions = [
      "s3:GetObject",
      "s3:GetObjectTagging",
      "s3:GetObjectVersion"
    ]
    resources = ["arn:aws:s3:::${var.QSS3BucketName}-${data.aws_region.current.name}/*", "${aws_s3_bucket.oracle-load-files.arn}/*"]

    effect = "Allow"
  }
}

data "aws_iam_policy_document" "oracle-ec2-policy-3" {
  statement {
    actions = [
      "ec2:DescribeInstances",
      "ec2:CreateTags"
    ]
    resources = ["*"]

    effect = "Allow"
  }
}

data "aws_iam_policy_document" "oracle-ec2-cloudwatch-policy-4" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogStreams"
    ]
    resources = ["arn:aws:logs:*:*:*"]

    effect = "Allow"
  }
}

data "aws_iam_policy" "AmazonSSMManagedInstanceCore" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

data "aws_iam_policy" "AmazonEC2RoleforSSM" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}






data "template_file" "userdata" {
  template = file("${path.module}/template/userdata.sh")

}

data "template_cloudinit_config" "config_oracle_server" {
  gzip          = true
  base64_encode = true

  # Main cloud-config configuration file.
  part {
    filename     = "userdata.sh"
    content_type = "text/x-shellscript"
    content      = data.template_file.userdata.rendered

  }


}


