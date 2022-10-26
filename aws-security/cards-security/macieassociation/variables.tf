
variable "member_account_list" {
  description = "The List of ID of the member AWS account to which the current AWS account is aassociated. Required if account_type is member"
  type        = list(string)
}

variable "bucket_name_list" {
  type        = list(string)
  description = "bucket name list for macie"
  default     = ["bucket1", "bucket2"]
}

variable "finding_publishing_frequency" {
  type        = string
  description = "finding-publishing-frequency"
  default     = "SIX_HOURS"
}
