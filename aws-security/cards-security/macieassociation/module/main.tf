resource "aws_macie_member_account_association" "association" {
  for_each          = toset(var.member_account_list)
  member_account_id = each.key
}

resource "aws_macie_s3_bucket_association" "example" {
  for_each    = toset(var.bucket_name_list)
  bucket_name = each.key
  prefix      = "data"

  #classification_type :  optional how the S3 objects are classified
  classification_type {
    one_time = "FULL"
  }
}
