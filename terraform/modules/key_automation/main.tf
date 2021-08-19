resource "tls_private_key" "automated" {
  algorithm = "RSA"
  rsa_bits  = 4096
  count     = var.upload_new_key == "y" && length(var.ssh_pub_key) == 0 ? 1 : 0
}
resource "aws_key_pair" "personal_key" {
  key_name   = var.ssh_key_name == true ? var.ssh_key_name : "gen_key_${formatdate("DD-YY", timestamp())}"
  public_key = var.ssh_pub_key == true ? var.ssh_pub_key : tls_private_key.automated[count.index].public_key_openssh

  count = var.upload_new_key == "y" ? 1 : 0
}

