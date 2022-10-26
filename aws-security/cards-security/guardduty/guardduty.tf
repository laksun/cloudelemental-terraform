#--------------
# GuardDuty 
# Needs to be setup for each region
#--------------

locals {
  guardduty_master_account_id = var.master_account_id
  guardduty_member_accounts   = var.member_accounts
}

module "guardduty_us-east-1" {
  source                       = "./module"
  master_account_id            = var.master_account_id
  guardduty_enabled            = var.guardduty_enabled
  finding_publishing_frequency = var.finding_publishing_frequency
  tags                         = var.tags
}
