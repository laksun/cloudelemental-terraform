# -----------------
# AWS Inspector
# -------------------
# Prereqisites
# Inspector agent on EC2 instances
# region-specific ARNs for rules packages

module "inspector_us-east-1" {
  source = "./module"


  name_prefix            = "cards"
  enable_scheduled_event = var.enable_scheduled_event
  # at 14:00 everyday
  schedule_expression = var.schedule_expression
  assessment_duration = var.assessment_duration
  # rulesets are read from datasource these become futile, for further reference keeping it as comment
  # ruleset_cve_enable                     = var.ruleset_cve_enable
  # ruleset_cve                            = var.ruleset_cve
  # ruleset_cis_enable                     = var.ruleset_cis_enable
  # ruleset_cis                            = var.ruleset_cis
  # ruleset_security_best_practices_enable = var.ruleset_security_best_practices_enable
  # ruleset_security_best_practices        = var.ruleset_security_best_practices
  # ruleset_network_reachability_enable    = var.ruleset_network_reachability_enable
  # ruleset_network_reachability           = var.ruleset_network_reachability


}
