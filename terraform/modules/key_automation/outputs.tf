output "key" {
  description = "Expose the value for personal keys"
  value       = aws_key_pair.personal_key[0].id
}


output "private_key" {
  description = "Created so private key can be passed upwards"
  sensitive   = true
  value       = tls_private_key.automated.*.private_key_pem
}
