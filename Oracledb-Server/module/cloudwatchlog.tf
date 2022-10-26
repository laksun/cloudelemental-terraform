resource "aws_cloudwatch_log_group" "oracle_cloudwatch_log_group" {
  name              = "${local.app_name}-oracleLogGroup"
  retention_in_days = var.retention == "" ? 7 : var.retention

  tags = local.oracle_tags
}


