# ----
# Enables GuardDuty
# ----

resource "aws_guardduty_detector" "primary" {
  count = var.guardduty_enabled ? 1 : 0

  enable                       = var.guardduty_enabled
  finding_publishing_frequency = var.finding_publishing_frequency

  tags = var.tags
}

# TODO: Account members should be added 
resource "aws_guardduty_member" "members" {
  #count = var.guardduty_enabled ? length(var.member_accounts) : 0
  for_each = toset(keys({ for i, r in var.member_accounts : i => r }))
  # credits to https://stackoverflow.com/questions/58594506/how-to-for-each-through-a-listobjects-in-terraform-0-12
  detector_id = aws_guardduty_detector.primary[0].id
  invite      = true
  #account_id                 = var.member_accounts[count.index].account_id
  account_id                 = var.member_accounts[each.value].account_id
  disable_email_notification = var.disable_email_notification
  #email                      = var.member_accounts[count.index].email
  email              = var.member_accounts[each.value].email
  invitation_message = var.invitation_message

}

resource "aws_guardduty_invite_accepter" "master" {
  count = var.guardduty_enabled && var.master_account_id != "" ? 1 : 0

  detector_id       = aws_guardduty_detector.primary[0].id
  master_account_id = var.master_account_id
}

