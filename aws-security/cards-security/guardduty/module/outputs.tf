output "guardduty_detector" {
  description = "The GuardDuty detector."
  value       = var.guardduty_enabled ? aws_guardduty_detector.primary[0] : null
}
