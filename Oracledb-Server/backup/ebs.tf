# locals {
#   # "Additional EBS block devices to attach to the instance"
#   ebs_block_device = [
#     {
#       device_name    = "/dev/xvda"
#       volume_type    = "gp2"
#       volume_size    = 20
#       encrypted      = true
#       deletionpolicy = true
#       name           = "aVolume"
#     },
#     {
#       device_name    = "/dev/xvdb"
#       volume_type    = "gp2"
#       volume_size    = 80
#       encrypted      = true
#       deletionpolicy = true
#       name           = "bVolume"
#     },
#     {
#       device_name    = "/dev/xvdc"
#       volume_type    = "gp2"
#       volume_size    = 60
#       encrypted      = true
#       deletionpolicy = true
#       name           = "cVolume"
#     },
#     {
#       device_name    = "/dev/xvdd"
#       volume_type    = "gp2"
#       volume_size    = 60
#       encrypted      = true
#       deletionpolicy = true
#       name           = "dTempdbVolume"
#     },
#     {
#       device_name    = "/dev/xvde"
#       volume_type    = "gp2"
#       volume_size    = 60
#       encrypted      = true
#       deletionpolicy = true
#       name           = "eVolume"
#     },
#     {
#       device_name    = "/dev/xvdx"
#       volume_type    = "gp2"
#       volume_size    = 25
#       encrypted      = true
#       deletionpolicy = true
#       name           = "xVolume"
#     },
#     {
#       device_name    = "/dev/xvdy"
#       volume_type    = "gp2"
#       volume_size    = 1
#       encrypted      = true
#       deletionpolicy = true
#       name           = "yVolume"
#     }
#     ,
#     {
#       device_name    = "/dev/xvdf"
#       volume_type    = var.DataVolumeType
#       iops           = var.DataIOPS
#       volume_size    = 50
#       encrypted      = false
#       deletionpolicy = true
#       name           = "fVolume"
#     },
#     {
#       device_name    = "/dev/xvdg"
#       volume_type    = var.DataVolumeType
#       iops           = var.DataIOPS
#       volume_size    = 50
#       encrypted      = false
#       deletionpolicy = true
#       name           = "gVolume"
#     },
#     {
#       device_name    = "/dev/xvdk"
#       volume_type    = var.DataVolumeType
#       iops           = var.DataIOPS
#       volume_size    = var.EBSData
#       encrypted      = true
#       deletionpolicy = true
#       name           = "kVolume"
#     },
#     {
#       device_name    = "/dev/xvdl"
#       volume_type    = var.DataVolumeType
#       iops           = var.DataIOPS
#       volume_size    = var.EBSData
#       encrypted      = true
#       deletionpolicy = true
#       name           = "lVolume"
#     },
#     {
#       device_name    = "/dev/xvdm"
#       volume_type    = var.DataVolumeType
#       iops           = var.DataIOPS
#       volume_size    = var.EBSData
#       encrypted      = true
#       deletionpolicy = true
#       name           = "mVolume"
#     },
#     {
#       device_name    = "/dev/xvdn"
#       volume_type    = var.DataVolumeType
#       iops           = var.DataIOPS
#       volume_size    = var.EBSData
#       encrypted      = true
#       deletionpolicy = true
#       name           = "nVolume"
#     },
#     {
#       device_name    = "/dev/xvdo"
#       volume_type    = var.DataVolumeType
#       iops           = var.DataIOPS
#       volume_size    = var.EBSData
#       encrypted      = false
#       deletionpolicy = true
#       name           = "oVolume"
#     },
#     {
#       device_name    = "/dev/xvdp"
#       volume_type    = var.DataVolumeType
#       iops           = var.DataIOPS
#       volume_size    = var.EBSData
#       encrypted      = false
#       deletionpolicy = true
#       name           = "pVolume"
#     }
#     ,
#     {
#       device_name    = "/dev/xvdh"
#       volume_type    = var.RecoVolumeType
#       iops           = var.RecoIOPS
#       volume_size    = var.EBSReco
#       encrypted      = false
#       deletionpolicy = true
#       name           = "hVolume"
#     }
#     ,
#     {
#       device_name    = "/dev/xvdi"
#       volume_type    = var.RecoVolumeType
#       iops           = var.RecoIOPS
#       volume_size    = var.EBSReco
#       encrypted      = false
#       deletionpolicy = true
#       name           = "iVolume"
#     }
#     ,
#     {
#       device_name    = "/dev/xvdj"
#       volume_type    = var.RecoVolumeType
#       iops           = var.RecoIOPS
#       volume_size    = var.EBSReco
#       encrypted      = false
#       deletionpolicy = true
#       name           = "jVolume"
#     }
#   ]
# }
