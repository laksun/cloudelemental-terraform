resource "aws_iam_role" "IdentityFunctionExecutionRole" {

  name               = "${local.app_name}-IdentityFunctionExecutionRole-${data.aws_region.current.name}"
  assume_role_policy = data.aws_iam_policy_document.IdentityFunctionExecution_Trust_Policy.json

  tags = local.common_tags
}

resource "aws_iam_role_policy" "instance_IdentityFunctionExecutionRole-policy-attach" {
  role   = aws_iam_role.IdentityFunctionExecutionRole.name
  policy = data.aws_iam_policy_document.IdentityFunctionExecution-policy.json
}

resource "aws_iam_instance_profile" "instance_oracle_server_profile" {
  name = "${local.app_name}-InstanceOracleServerProfile"
  role = aws_iam_role.OracleInstanceRole.name
}

resource "aws_iam_role" "OracleInstanceRole" {

  name               = "${local.app_name}-OracleInstanceRole-${data.aws_region.current.name}"
  assume_role_policy = data.aws_iam_policy_document.OracleInstanceRole_trust_policy.json

  tags = local.common_tags
}

resource "aws_iam_role_policy_attachment" "OracleInstanceRole-ssm-policy-attach" {
  role       = aws_iam_role.OracleInstanceRole.name
  policy_arn = data.aws_iam_policy.AmazonSSMManagedInstanceCore.arn
}

resource "aws_iam_role_policy_attachment" "OracleInstanceRole-ec2roleforssm-policy-attach" {
  role       = aws_iam_role.OracleInstanceRole.name
  policy_arn = data.aws_iam_policy.AmazonEC2RoleforSSM.arn
}

resource "aws_iam_role_policy" "OracleInstanceRole-policy-attach1" {
  role   = aws_iam_role.OracleInstanceRole.name
  policy = data.aws_iam_policy_document.oracle-ec2-s3-policy-1.json
}

resource "aws_iam_role_policy" "OracleInstanceRole-policy-attach2" {
  role   = aws_iam_role.OracleInstanceRole.name
  policy = data.aws_iam_policy_document.oracle-ec2-s3-policy-2.json
}

resource "aws_iam_role_policy" "OracleInstanceRole-policy-attach3" {
  role   = aws_iam_role.OracleInstanceRole.name
  policy = data.aws_iam_policy_document.oracle-ec2-policy-3.json
}


resource "aws_iam_role_policy" "OracleInstanceRole-policy-attach4" {
  role   = aws_iam_role.OracleInstanceRole.name
  policy = data.aws_iam_policy_document.oracle-ec2-cloudwatch-policy-4.json
}

