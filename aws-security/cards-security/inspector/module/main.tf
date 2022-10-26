###----
##     AWS inspector module
##-----

locals {
  scheduled_count = var.enable_scheduled_event ? 1 : 0
  #   assessment_ruleset = compact([
  #     var.ruleset_cis_enable ? var.ruleset_cis : "",
  #     var.ruleset_cve_enable ? var.ruleset_cve : "",
  #     var.ruleset_network_reachability_enable ? var.ruleset_network_reachability : "",
  #     var.ruleset_security_best_practices_enable ? var.ruleset_security_best_practices : "",
  #     ]
  #   )
}
#or 
# Declare the data source
data "aws_inspector_rules_packages" "rules" {}

data "aws_iam_policy_document" "inspector_event_role_policy" {
  count = local.scheduled_count
  statement {
    sid = "StartAssessment"
    actions = [
      "inspector:StartAssessmentRun",
    ]
    resources = [
      "*"
    ]
  }
}


resource "aws_inspector_assessment_target" "assessment_target" {
  name = "${var.name_prefix}-assessment-target"
}

resource "aws_inspector_assessment_template" "assessment" {
  name       = "${var.name_prefix}-assessment-template"
  target_arn = aws_inspector_assessment_target.assessment_target.arn
  duration   = var.assessment_duration
  #rules_package_arns = local.assessment_ruleset
  rules_package_arns = data.aws_inspector_rules_packages.rules.arns
}

resource "aws_iam_role" "inspector_event_role" {
  count = local.scheduled_count
  name  = "${var.name_prefix}-inspector-event-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "events.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "inspector_event_policy" {
  count  = local.scheduled_count
  name   = "${var.name_prefix}-inspector-event-policy"
  role   = aws_iam_role.inspector_event_role[0].id
  policy = data.aws_iam_policy_document.inspector_event_role_policy[0].json
}

resource "aws_cloudwatch_event_rule" "inspector_event_schedule" {
  count               = local.scheduled_count
  name                = "${var.name_prefix}-inspector-schedule"
  description         = "Trigger an Inspector Assessment"
  schedule_expression = var.schedule_expression
}

resource "aws_cloudwatch_event_target" "inspector_event_target" {
  count    = local.scheduled_count
  rule     = aws_cloudwatch_event_rule.inspector_event_schedule[0].name
  arn      = aws_inspector_assessment_template.assessment.arn
  role_arn = aws_iam_role.inspector_event_role[0].arn
}
