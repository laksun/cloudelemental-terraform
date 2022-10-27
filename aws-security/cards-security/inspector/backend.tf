
provider "aws" {
  region = "us-east-1"
}
# terraform {
#   # required_version = "0.13.5"
#   # TODO: add Dynamodb locking
#   backend "s3" {
#     bucket         = "terraform-state-us-east-1"
#     dynamodb_table = "TerraformStatelock"
#     key            = "terraform.tfstate"
#     region         = "us-east-1"
#     #profile        = "techopsexp1"
#   }
# }
