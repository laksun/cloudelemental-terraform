
resource "aws_instance" "OracleServer" {
  ami = var.oracleserver_ami == "" ? data.aws_ami.hardened_oracle_server_ami.id : var.oracleserver_ami

  instance_type        = var.instance_type
  iam_instance_profile = aws_iam_instance_profile.instance_oracle_server_profile.name

  subnet_id = local.primary_subnet_id
  root_block_device {
    delete_on_termination = lookup(var.root_block_device, "delete_on_termination", true)
    encrypted             = lookup(var.root_block_device, "encrypted", true)
    volume_size           = lookup(var.root_block_device, "volume_size", 30)
    volume_type           = lookup(var.root_block_device, "volume_type", "gp2")

  }

  dynamic "ebs_block_device" {
    for_each = local.ebs_block_device
    content {
      delete_on_termination = lookup(ebs_block_device.value, "deletionpolicy", null)
      device_name           = ebs_block_device.value.device_name
      encrypted             = lookup(ebs_block_device.value, "encrypted", null)
      iops                  = var.io_volume_type == "" ? lookup(ebs_block_device.value, "iops", null) : var.io_volume_type
      volume_size           = lookup(ebs_block_device.value, "volume_size", null)
      volume_type           = lookup(ebs_block_device.value, "volume_type", null)
      tags                  = merge(local.common_tags, { "Name" = format("%s", ebs_block_device.value.device_name) })
    }
  }

  disable_api_termination = var.disable_api_termination
  user_data               = data.cloudinit_config.oracle-config.rendered
  security_groups         = [aws_security_group.OracleServerSecurityGroup.id, var.BastionSecurityGroupID, aws_security_group.OracleServersSecurityGroup.id, aws_security_group.SkyApplianceSecurityGroup.id]
  tags                    = merge(local.common_tags, { "Name" = format("%s", local.primaryDatabaseUniqueName) })
  depends_on              = [aws_s3_bucket_object.orcl-setup_file_upload]
}


resource "aws_ssm_document" "commands-install-oracle" {
  name            = local.primary_document_name
  document_type   = "Automation"
  document_format = "YAML"
  content         = data.template_file.main-commands-file.rendered


  tags       = local.common_tags
  depends_on = [aws_instance.OracleServer]

  lifecycle {
    ignore_changes = all
  }
}

resource "aws_ssm_association" "oracle_install" {
  name = aws_ssm_document.commands-install-oracle.name

  association_name = format("%s-association", local.app_name)
  parameters = {
    InstanceId          = aws_instance.OracleServer.id
    DataMigrationVolume = local.CreateEFSVolume ? var.DataMigrationVolume : "No"
    mountPoint          = local.CreateEFSVolume ? "/data_migration" : ""
    volumeURL           = local.CreateEFSVolume ? local.FileSystemURL : ""
    StandbyInstanceId   = local.createStandby == "Yes" ? aws_instance.OracleServerStandby[0].id : ""
    createStandby       = local.createStandby
  }

  depends_on = [time_sleep.wait_ssm_association]

  lifecycle {
    ignore_changes = all
  }

}

####EBS Volumes


# resource "aws_ebs_volume" "ebs_volumes" {
#   count             = var.mainDiskNumber
#   availability_zone = aws_instance.OracleServer.availability_zone
#   size              = var.VolumeSize
#   type              = var.VolumeType
#   iops              = var.VolumeType == "io2" ? var.VolumeIops : null
#   throughput        = var.VolumeType == "gp3" ? var.VolumeGroupThroughput : null
#   tags              = merge(local.common_tags, { "Name" = element(local.ec2_data_device_names, count.index) })

# }

# resource "aws_volume_attachment" "ebs_volumes_attach" {
#   count       = var.mainDiskNumber
#   device_name = element(local.ec2_data_device_names, count.index)
#   volume_id   = aws_ebs_volume.ebs_volumes.*.id[count.index]
#   instance_id = aws_instance.OracleServer.id

#   force_detach = true
#   depends_on   = [time_sleep.wait_ec2_1]
# }

###Log Volumes
# resource "aws_ebs_volume" "ebs_log_volumes" {
#   count             = var.logDiskNumber
#   availability_zone = aws_instance.OracleServer.availability_zone
#   size              = var.LogVolumeSize
#   type              = var.LogVolumeType
#   iops              = var.LogVolumeType == "io2" ? var.LogVolumeIops : null
#   throughput        = var.LogVolumeType == "gp3" ? var.LogVolumeGroupThroughput : null

#   tags = merge(local.common_tags, { "Name" = element(local.ec2_data_device_names, (count.index + var.mainDiskNumber)) })

# }

# resource "aws_volume_attachment" "ebs_log_volumes_attach" {
#   count       = var.logDiskNumber
#   device_name = element(local.ec2_data_device_names, (count.index + var.mainDiskNumber))
#   volume_id   = aws_ebs_volume.ebs_log_volumes.*.id[count.index]
#   instance_id = aws_instance.OracleServer.id

#   force_detach = true
#   depends_on   = [time_sleep.wait_ec2_2]
# }

###Reco Volumes
# resource "aws_ebs_volume" "ebs_reco_volumes" {
#   count             = var.recoDiskNumber
#   availability_zone = aws_instance.OracleServer.availability_zone
#   size              = var.RecoVolumeSize
#   type              = var.RecoVolumeType
#   iops              = var.RecoVolumeType == "io2" ? var.RecoVolumeIops : null
#   throughput        = var.RecoVolumeType == "gp3" ? var.RecoVolumeGroupThroughput : null

#   tags = merge(local.common_tags, { "Name" = element(local.ec2_data_device_names, (count.index + var.mainDiskNumber + var.logDiskNumber)) })


# }

# resource "aws_volume_attachment" "ebs_reco_volumes_attach" {
#   count       = var.recoDiskNumber
#   device_name = element(local.ec2_data_device_names, (count.index + var.mainDiskNumber + var.logDiskNumber))
#   volume_id   = aws_ebs_volume.ebs_reco_volumes.*.id[count.index]
#   instance_id = aws_instance.OracleServer.id

#   force_detach = true
#   depends_on   = [time_sleep.wait_ec2_3]
# }

###Data Volumes
# resource "aws_ebs_volume" "ebs_data_volumes" {
#   count             = var.dataDiskNumber
#   availability_zone = aws_instance.OracleServer.availability_zone
#   size              = var.DataVolumeSize
#   type              = var.DataVolumeType
#   iops              = var.DataVolumeType == "io2" ? var.DataVolumeIops : null
#   throughput        = var.DataVolumeType == "gp3" ? var.DataVolumeGroupThroughput : null

#   tags = merge(local.common_tags, { "Name" = element(local.ec2_data_device_names, (count.index + var.mainDiskNumber + var.logDiskNumber + var.recoDiskNumber)) })

# }

# resource "aws_volume_attachment" "ebs_data_volumes_attach" {
#   count       = var.dataDiskNumber
#   device_name = element(local.ec2_data_device_names, (count.index + var.mainDiskNumber + var.logDiskNumber + var.recoDiskNumber))
#   volume_id   = aws_ebs_volume.ebs_data_volumes.*.id[count.index]
#   instance_id = aws_instance.OracleServer.id

#   force_detach = true
#   depends_on   = [time_sleep.wait_ec2_4]
# }

###swap Volumes
# resource "aws_ebs_volume" "ebs_swap_volumes" {
#   count             = var.swapDiskNumber
#   availability_zone = aws_instance.OracleServer.availability_zone
#   size              = var.SwapVolumeSize
#   type              = var.SwapVolumeType
#   iops              = var.SwapVolumeType == "io2" ? var.SwapVolumeIops : null
#   throughput        = var.SwapVolumeType == "gp3" ? var.SwapVolumeGroupThroughput : null

#   tags = merge(local.common_tags, { "Name" = element(local.ec2_data_device_names, (count.index + var.mainDiskNumber + var.logDiskNumber + var.recoDiskNumber + var.dataDiskNumber)) })

# }

# resource "aws_volume_attachment" "ebs_swap_volumes_attach" {
#   count       = var.swapDiskNumber
#   device_name = element(local.ec2_data_device_names, (count.index + var.mainDiskNumber + var.logDiskNumber + var.recoDiskNumber + var.dataDiskNumber))
#   volume_id   = aws_ebs_volume.ebs_swap_volumes.*.id[count.index]
#   instance_id = aws_instance.OracleServer.id

#   force_detach = true
#   depends_on   = [time_sleep.wait_ec2_5]
# }



