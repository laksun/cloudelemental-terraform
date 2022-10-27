resource "tls_private_key" "this" {
  algorithm = "RSA"
}

module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"

  key_name = "${local.app_name}-oracle-key"

  public_key = tls_private_key.this.public_key_openssh
}

resource "aws_instance" "OracleServer" {
  ami = var.oracleserver_ami

  instance_type               = var.instance_type
  iam_instance_profile        = aws_iam_instance_profile.instance_oracle_server_profile.name
  subnet_id                   = var.public_subnet_id
  associate_public_ip_address = var.assign_public_ip
  key_name                    = module.key_pair.key_pair_key_name


  root_block_device {
    delete_on_termination = lookup(var.root_block_device, "delete_on_termination", true)
    encrypted             = lookup(var.root_block_device, "encrypted", true)
    volume_size           = lookup(var.root_block_device, "volume_size", 20)
    volume_type           = lookup(var.root_block_device, "volume_type", "gp2")

  }

  dynamic "ebs_block_device" {
    for_each = var.ebs_block_device
    content {
      delete_on_termination = lookup(ebs_block_device.value, "deletionpolicy", null)
      device_name           = ebs_block_device.value.device_name
      encrypted             = lookup(ebs_block_device.value, "encrypted", null)
      iops                  = var.io_volume_type == "" ? lookup(ebs_block_device.value, "iops", null) : var.io_volume_type
      volume_size           = lookup(ebs_block_device.value, "volume_size", null)
      volume_type           = lookup(ebs_block_device.value, "volume_type", null)
      tags                  = merge(local.common_tags, { "Name" = format("%s", ebs_block_device.value.name) })
    }
  }


  user_data_base64 = data.template_cloudinit_config.config_oracle_server.rendered
  tags             = merge(local.common_tags, { "Name" = format("%s", local.app_name) })
}

resource "aws_ebs_volume" "reco_volumes" {
  count = length(var.reco_block_devices)

  availability_zone = aws_instance.OracleServer.availability_zone
  size              = var.reco_block_devices[count.index].size
  type              = var.reco_block_devices[count.index].type
  iops              = var.reco_block_devices[count.index].iops
}

resource "aws_volume_attachment" "reco_volume_attach" {
  count = length(var.reco_block_devices)

  device_name = var.reco_block_devices[count.index].name
  volume_id   = aws_ebs_volume.reco_volumes[count.index].id
  instance_id = aws_instance.OracleServer.id
}

resource "aws_ebs_volume" "data_volumes" {
  count = length(var.dataiops_block_devices)

  availability_zone = aws_instance.OracleServer.availability_zone
  size              = var.dataiops_block_devices[count.index].size
  type              = var.dataiops_block_devices[count.index].type
  iops              = var.dataiops_block_devices[count.index].iops
}

resource "aws_volume_attachment" "data_volume_attach" {
  count = length(var.dataiops_block_devices)

  device_name = var.dataiops_block_devices[count.index].name
  volume_id   = aws_ebs_volume.data_volumes[count.index].id
  instance_id = aws_instance.OracleServer.id
}
