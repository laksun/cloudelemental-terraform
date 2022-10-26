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
  ports                                  = [5500, 111, 2049, 32768, 44182, 54508]
  subnet_id                              = sort(data.aws_subnet_ids.private_subnets.ids)[0]
  #logGroupName                    = "${var.oracledb_name}-${var.env}-${var.logGroupName}"
  #### Oracle roles
  oracle_tags = {
    "BlueprintSource"  = "it.ec2.cloudformation.oracle"
    "BlueprintVersion" = var.BlueprintVersion
    # "Contact"  = var.Contact
    # "Service"  = var.ProductCode
    # "Environment" = var.EnvironmentCode
    # "OrgId" = var.OrgId
    # "Capacity" = var.Capacity
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

# data "aws_ami" "hardened_oracle_server_ami" {
#   most_recent = true
#   filter {
#     name   = "architecture"
#     values = ["x86_64"]
#   }

#   filter {
#     name   = "root-device-type"
#     values = ["ebs"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }

#   filter {
#     name   = "name"
#     values = ["a*"]
#   }

#   owners = [var.owner]
# }


data "template_file" "userdata" {
  template = file("${path.module}/template/userdata.sh")
  # vars = {
  #   instance_name          = local.app_name
  #   CloudWatchLogGroupName = local.logGroupName
  # }
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

  # part {
  #   content_type = "text/x-shellscript"
  #   content      = data.template_file.cloud_init_cw_agent.rendered

  # }
}

# data "template_file" "cloudwatch_agent_configuration_standard" {
#   template = "${file("${path.module}/templates/cloudwatch_agent_configuration_standard.json")}"

#   vars {
#     aggregation_dimensions      = "${jsonencode(var.aggregation_dimensions)}"
#     cpu_resources               = "${var.cpu_resources}"
#     disk_resources              = "${jsonencode(var.disk_resources)}"
#     metrics_collection_interval = "${var.metrics_collection_interval}"
#   }
# }
