variable "enabled" {
  description = "The boolean flag whether this module is enabled or not. No resources are created when set to false."
  default     = true
}

# variable "member_accounts" {
#     description = "A list of IDs and emails of AWS accounts which associated as member accounts"
#     type = list(object({
#         account_id = string
#         email = string
#     }))
#     default = []

# }
# from list to map
variable "member_accounts" {
  description = "Map of IDs and emails of AWS accounts which associated as member accounts"
  type = map(object({
    account_id = string
    email      = string
  }))
}

variable "enable_cis_standard" {
  description = "Boolean whether CIS standard is enabled."
  default     = true
}

variable "enable_aws_foundational_standard" {
  description = "Boolean whether AWS Foundations standard is enabled."
  default     = true
}

variable "enable_pci_dss_standard" {
  description = "Boolean whether PCI DSS standard is enabled"
  default     = true
}
