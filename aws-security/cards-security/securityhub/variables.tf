variable "target_regions" {
  type        = list(string)
  description = "A list of regions to set up this module"
  default = [
    "us-east-2",
    "us-east-1"
  ]
}

variable "securityhub_enable_cis_standard" {
  description = "Boolean whether CIS standard is enabled."
  default     = true
}

variable "securityhub_enable_pci_dss_standard" {
  description = "Boolean whether PCI DSS standard is enabled."
  default     = false
}

variable "securityhub_enable_aws_foundational_standard" {
  description = "Boolean whether AWS Foundations standard is enabled."
  default     = true
}

variable "member_accounts" {
  description = "Map of IDs and emails of AWS accounts which associated as member accounts"
  type = map(object({
    account_id = string
    email      = string
  }))
  default = {}
}



# this should be a list
variable "member_account_id" {
  description = "The ID of the member AWS account to which the current AWS account is aassociated. Required if account_type is member"
  default     = "455555667777"
}
