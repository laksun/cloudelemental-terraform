variable "name_prefix" {
  description = "Name prefix for inspector target"
  default     = "cards"
}


variable "assessment_duration" {
  type        = string
  description = "The duration of the Inspector assessment run"
  default     = "3600" # 1 hour
}

variable "enable_scheduled_event" {
  type        = bool
  description = "Enable Cloudwatch Events to schedule an assessment"
  default     = true
}

variable "ruleset_cis_enable" {
  type        = bool
  description = "Enable CIS Operating System Security Configuration Benchmarks Ruleset"
  default     = true
}

variable "ruleset_cis" {
  type        = string
  description = " CIS Operating System Security Configuration Benchmarks Ruleset"
  default     = "arn:aws:inspector:us-east-1:*:rulespackage/0-rExsr2X8"
}

variable "ruleset_cve_enable" {
  type        = bool
  description = "Enable Common Vulnerabilities and Exposures Ruleset"
  default     = true
}

variable "ruleset_cve" {
  type        = string
  description = " Common Vulnerabilities and Exposures Ruleset"
  default     = "arn:aws:inspector:us-east-1:*:rulespackage/0-gEjTy7T7"
}

variable "ruleset_network_reachability_enable" {
  type        = bool
  description = "Enable AWS Network Reachability Ruleset"
  default     = true
}

variable "ruleset_network_reachability" {
  type        = string
  description = "AWS Network Reachability Ruleset"
  default     = "arn:aws:inspector:us-east-1:*:rulespackage/0-PmNV0Tcd"
}

variable "ruleset_security_best_practices_enable" {
  type        = bool
  description = "Enable AWS Security Best Practices Ruleset"
  default     = true
}

variable "ruleset_security_best_practices" {
  type        = string
  description = "AWS Security Best Practices Ruleset"
  default     = "arn:aws:inspector:us-east-1:*:rulespackage/0-R01qwB5Q"
}

variable "schedule_expression" {
  type        = string
  description = "AWS Schedule Expression: https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html"
  default     = "rate(7 days)"
}
