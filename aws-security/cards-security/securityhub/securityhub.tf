# -----------------
# SecurityHub 
# -------------------

locals {
  securityhub_member_account = var.member_accounts
}

module "securityhub_us-east-1" {
  source = "./module"


  enabled                          = contains(var.target_regions, "us-east-1")
  enable_cis_standard              = var.securityhub_enable_cis_standard
  enable_pci_dss_standard          = var.securityhub_enable_pci_dss_standard
  enable_aws_foundational_standard = var.securityhub_enable_aws_foundational_standard
  member_accounts                  = local.securityhub_member_account

}

# enable security hub
# subscribe CIS benchmark standard
# subscribe PCI DSS standard
# subscribe AWS foundational security best practices standard

