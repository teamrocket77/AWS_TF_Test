output "ip" {
  description = "IP Address for SSH here"
  value       = aws_eip.this[0].public_ip
}

output "iskey" {
  value = var.ssh_pub_key == true ? "yes" : "no"
}
output "iskey2" {
  value = var.ssh_pub_key == false ? "yes" : "no"
}
output "PUBKEY" {
  value = var.ssh_pub_key == "y" ? "yes" : "no"
}

output "uploadanewkey" {
  value = var.upload_new_key == "y" ? "yes" : "no"
}

output "key_name" {
  description = "Passes the name of the new key up"
  value       = var.ssh_key_name
}
