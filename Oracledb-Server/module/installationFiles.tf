resource "aws_s3_bucket" "oracle-load-files" {
  bucket = "${local.app_name}-oracle-files"

  tags = merge(local.common_tags, { "Name" = format("%s", local.app_name) })
}