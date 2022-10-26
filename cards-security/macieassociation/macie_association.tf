# -----------------
# AWS Macie
# -------------------
# Prereqisites
# Macie should be enabled manually

resource "null_resource" "enablemacie" {
  provisioner "local-exec" {
    command = "aws enable-macie --finding-publishing-frequency ${var.finding_publishing_frequency} --status ENABLED"
  }
}

module macie_us-east-1 {
  source = "./module"

  member_account_list = var.member_account_list
  bucket_name_list    = var.bucket_name_list

}
