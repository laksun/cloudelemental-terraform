variable "oracledb_name" {
  type        = string
  description = "Name to be used for the Oracle DB in addition to the product Name"
}

variable "env" {
  type        = string
  description = "Environment for which Oracle DB would be used"
}


variable "product" {
  type        = string
  description = "Product that will own the EC2 Oracle Database"
}

variable "QSS3BucketName" {
  type        = string
  description = "Oracle Database S3 Bucket"
}

variable "tags" {
  type        = map(string)
  description = "Tag Map to add to all resources. Basic Tags will be added by default"
}


variable "BlueprintVersion" {
  type    = string
  default = ""
}

variable "Contact" {
  type    = string
  default = ""
}

variable "ProductCode" {
  type    = string
  default = ""
}

variable "EnvironmentCode" {
  type    = string
  default = ""
}

variable "OrgId" {
  type    = string
  default = ""
}

variable "Capacity" {
  type    = string
  default = ""
}

variable "create_oracle_security_group" {
  type        = bool
  description = "Boolean to decide whether or not to create oracle security group"
  default     = true
}

variable "BastionSecurityGroupID" {
  type    = string
  default = "sg-0a8f8ef1107f1863c"
}

variable "DatabasePort" {
  type        = string
  description = "Oracle Database listener port number."
  default     = "1521"
}

variable "vpc_id" {
  type    = string
  default = ""
}

variable "activioAppliancePort" {
  type        = string
  description = "port 5106 from the Actifio Sky appliance"
  default     = "5106"
}

variable "retention" {
  type        = string
  description = "retention"
  default     = ""
}

variable "oracleserver_ami" {
  type        = string
  description = "Create a Primary and optionally a Standby EC2 instance, using the latest RHEL7 hardened AMI -- AMI ID to be used by the EC2 Instance"
  default     = ""
}

variable "instance_type" {
  type        = string
  description = "oracle instance type"
  default     = "r5.4xlarge"
}

variable "owner" {
  type        = string
  description = "owner for the oracle server ami"
  default     = ""
}

variable "root_block_device" {
  type        = map(string)
  description = "aws intance root_block_device properties "
  default = {
    device_name           = "/dev/xvda"
    delete_on_termination = true
    encrypted             = true
    volume_size           = 20
    volume_type           = "gp2"
  }
}

variable "ebs_block_device" {
  type        = list(map(string))
  description = "Additional EBS block devices to attach to the instance"
  default = [
    {
      device_name    = "/dev/xvdb"
      volume_type    = "gp2"
      volume_size    = 40
      encrypted      = true
      deletionpolicy = true
      name           = "bVolume"
    }
    #   ,
    #   {
    #     device_name    = "/dev/xvdc"
    #     volume_type    = "gp2"
    #     volume_size    = 60
    #     encrypted      = true
    #     deletionpolicy = true
    #     name           = "cVolume"
    #   },
    #   {
    #     device_name    = "/dev/xvdd"
    #     volume_type    = "gp2"
    #     volume_size    = 60
    #     encrypted      = true
    #     deletionpolicy = true
    #     name           = "dTempdbVolume"
    #   },
    #   {
    #     device_name    = "/dev/xvde"
    #     volume_type    = "gp2"
    #     volume_size    = 10
    #     encrypted      = true
    #     deletionpolicy = true
    #     name           = "eVolume"
    #   },
    #   {
    #     device_name    = "/dev/xvdx"
    #     volume_type    = "gp2"
    #     volume_size    = 25
    #     encrypted      = true
    #     deletionpolicy = true
    #     name           = "xVolume"
    #   },
    #   {
    #     device_name    = "/dev/xvdy"
    #     volume_type    = "gp2"
    #     volume_size    = 1
    #     encrypted      = true
    #     deletionpolicy = true
    #     name           = "yVolume"
    # }
  ]
}

variable "dataIOPS" {
  type    = string
  default = ""
}

variable "dataVolumeType" {
  type    = string
  default = ""
}

variable "dataVolumeSize" {
  type    = string
  default = ""
}

variable "dataiops_block_devices" {
  type        = list(map(string))
  description = "dataiops ebs volumes"
  default = [
    { name = "/dev/xvdf", type = "io2", size = "50", iops = 1000 },
    { name = "/dev/xvdg", type = "io2", size = "50", iops = 1000 },
    { name = "/dev/xvdk", type = "io2", size = "6", iops = 1000 },
    { name = "/dev/xvdl", type = "io2", size = "6", iops = 1000 },
    { name = "/dev/xvdm", type = "io2", size = "6", iops = 1000 },
    { name = "/dev/xvdn", type = "io2", size = "6", iops = 1000 },
    { name = "/dev/xvdo", type = "io2", size = "6", iops = 1000 },
    { name = "/dev/xvdp", type = "io2", size = "6", iops = 1000 },
  ]
}

variable "reco_block_devices" {
  type        = list(map(string))
  description = "reco ebs volumes"
  default = [
    { name = "/dev/xvdh", type = "io2", size = "4", iops = 1000 },
    { name = "/dev/xvdi", type = "io2", size = "4", iops = 1000 },
    { name = "/dev/xvdj", type = "io2", size = "4", iops = 1000 }
  ]
}

variable "assign_public_ip" {
  type        = bool
  description = "assign public ip "
  default     = "false"
}

variable "public_subnet_id" {
  type        = string
  description = "ami id for the sql server if user wants a specific ami id "
  default     = "subnet-x"
}

variable "io_volume_type" {
  type        = string
  description = "volume type"
  default     = ""
}



