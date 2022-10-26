
variable "member_accounts" {
  description = "A list of IDs and emails of AWS accounts which associated as member accounts."
  type = list(object({
    account_id = string
    email      = string
  }))
  default = []
}

##### Guardduty variables

variable "master_account_id" {
  description = "The ID of the master AWS account to which the current AWS account is associated. Required if account_type is member"
  default     = ""
}
variable "finding_publishing_frequency" {
  description = "Specifies the frequency of notifications sent for subsequent finding occurrences."
  default     = "SIX_HOURS"
}

variable "guardduty_enabled" {
  description = "The boolean flag whether this module is enabled or not. No resources are created when set to false."
  default     = true
}

variable "tags" {
  description = "Specifies object tags key and value. This applies to all resources created by this module."
  default = {
    "Environment" = "Development"
  }
}

variable "disable_email_notification" {
  description = "Boolean whether an email notification is sent to the accounts."
  default     = false
}



