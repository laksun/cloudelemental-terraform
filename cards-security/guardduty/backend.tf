
provider "aws" {
  region = "us-east-1"
}
# terraform {
#   # required_version = "0.13.5"
#   # TODO: add Dynamodb locking
#   backend "s3" {
#     bucket         = ""
#     dynamodb_table = "TerraformStatelock"
#     key            = "cards-security/terraform.tfstate"
#     region         = "us-east-1"
#     #profile        = ""
#   }
# }
