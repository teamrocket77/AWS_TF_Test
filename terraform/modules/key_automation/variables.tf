variable "ssh_key_name" {
  description = <<-EOF
  Name of SSH key to be used. If there isn't a key name here
  a random key will be generated in the format gen_key_DD_YY.
  D: Day
  Y: year
  EOF
}
variable "ssh_pub_key" {
  description = <<-EOF
  Insert public key here. If no key is inserted there will be a private key pem file
  generated and saved inside of the directory under the name priv_key.pem
  Also note, TF will ask for this whether or not you upload a new key or not.
  EOF
}
variable "upload_new_key" {
  description = <<-EOF
  Should we upload a new key to AWS? y/n"
  This question is asking if a new key should be created or if you are using a previously created one.
  EOF
}
