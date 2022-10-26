module "base_tags" {
  source = "/Users/macpro/code/common-config"

  product       = var.product
  environment   = var.env
  devops_module = true
}

locals {
  common_tags = merge(module.base_tags.tags, var.tags)
}
