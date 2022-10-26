output "oracle_serveraccess_security_group_arn" {
  description = "Arn of the oracle server access security group"
  value       = aws_security_group.OracleServerAccessSecurityGroup.arn

}

output "oracle_server_security_group_arn" {
  description = "Arn of the oracle server security group"
  value       = aws_security_group.OracleServerSecurityGroup.arn

}

output "oracle_servers_security_group_arn" {
  description = "Arn of the oracle servers security group"
  value       = aws_security_group.OracleServersSecurityGroup.arn

}

output "oracle_skyappliance_security_group_arn" {
  description = "Arn of the skyappliance security group"
  value       = aws_security_group.SkyApplianceSecurityGroup.arn

}

output "oracle_cloudwatch_log_group_arn" {
  description = "Cloudwatch Log group"
  value       = aws_cloudwatch_log_group.oracle_cloudwatch_log_group.arn

}

output "private_key_pem" {
  value = tls_private_key.this.private_key_pem
}

output "availability_zone" {
  description = "Availability zone of instance"
  value       = aws_instance.OracleServer.availability_zone
}

output "placement_group" {
  description = "Placement groups of instance"
  value       = aws_instance.OracleServer.placement_group
}

output "key_name" {
  description = "Key name of instance"
  value       = aws_instance.OracleServer.key_name
}

output "instance_profile_id" {
  description = "Id of the oracle instance profile id"
  value       = aws_iam_instance_profile.instance_oracle_server_profile.id
}

output "instance_profile_arn" {
  description = "Arn of the oracle server instance role"
  value       = aws_iam_instance_profile.instance_oracle_server_profile.arn
}

