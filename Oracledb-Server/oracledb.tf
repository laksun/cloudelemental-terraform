locals {
  region = "eu-west-1"
}
module "oracledb" {
  source         = "./module"
  product        = "xyz"
  oracledb_name  = "oracledb"
  env            = "ci"
  QSS3BucketName = "myoracle-bucket"
  tags           = { product = "" }

  instance_type          = "t3.large"
  oracleserver_ami       = "ami-"
  public_subnet_id       = "subnet-"
  assign_public_ip       = true
  BastionSecurityGroupID = "sg-"

}


