
locals {
  security_group_cidrs = [var.security_group_cidrs]
}

resource "aws_security_group" "OracleServerAccessSecurityGroup" {
  name        = local.oracle_ServerAccessSecurity_group_name
  description = "Instances with access to Oracle servers"
  vpc_id      = var.vpc_id != "" ? var.vpc_id : data.aws_cloudformation_export.vpc_id.value

  tags = local.common_tags
}

resource "aws_security_group" "OracleServerSecurityGroup" {
  name        = local.oracle_security_group_name
  description = "Security Group for the Oracle Server"
  vpc_id      = var.vpc_id != "" ? var.vpc_id : data.aws_cloudformation_export.vpc_id.value

  ingress {
    description     = "ssh access"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [var.BastionSecurityGroupID]
  }

  ingress {
    description     = "database access"
    from_port       = var.DatabasePort
    to_port         = var.DatabasePort
    protocol        = "tcp"
    security_groups = [aws_security_group.OracleServerAccessSecurityGroup.id]
  }

  ingress {
    description     = "port 5500 access"
    from_port       = 5500
    to_port         = 5500
    protocol        = "tcp"
    security_groups = [aws_security_group.OracleServerAccessSecurityGroup.id]
  }


  tags = local.common_tags
}

resource "aws_security_group" "OracleServersSecurityGroup" {
  name        = local.oracleservers_security_group_name
  description = "Instances with access to Oracle servers"
  vpc_id      = var.vpc_id != "" ? var.vpc_id : data.aws_cloudformation_export.vpc_id.value

  ingress {
    description     = "ssh access"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.OracleServerAccessSecurityGroup.id]
  }

  ingress {
    description     = "database access"
    from_port       = var.DatabasePort
    to_port         = var.DatabasePort
    protocol        = "tcp"
    security_groups = [aws_security_group.OracleServerAccessSecurityGroup.id]
  }

  dynamic "ingress" {
    for_each = local.ports
    content {
      description     = "Security Group for the SQL Cluster ${ingress.key}"
      from_port       = ingress.value
      to_port         = ingress.value
      protocol        = "tcp"
      security_groups = [aws_security_group.OracleServerAccessSecurityGroup.id]
    }
  }

  tags = local.common_tags
}

resource "aws_security_group" "SkyApplianceSecurityGroup" {
  name        = local.oracle_skyappliance_group_name
  description = "Instances with access to Oracle servers"
  vpc_id      = var.vpc_id != "" ? var.vpc_id : data.aws_cloudformation_export.vpc_id.value

  ingress {
    description     = "from the   appliance"
    from_port       = var.activioAppliancePort
    to_port         = var.activioAppliancePort
    protocol        = "tcp"
    security_groups = [aws_security_group.OracleServerAccessSecurityGroup.id]
  }

  tags = local.common_tags
}
