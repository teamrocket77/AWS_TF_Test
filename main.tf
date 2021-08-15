data "aws_vpc" "main" {
  default = true
}

data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.main.id
}

data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name = "name"

    values = [
      "amzn-ami-hvm-*-x86_64-gp2",
    ]
  }

  filter {
    name = "owner-alias"

    values = [
      "amazon",
    ]
  }
}

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

resource "local_file" "gen_key" {
  content  = tls_private_key.automated[count.index].private_key_pem
  filename = "${path.module}/priv_key.pem"
  count    = length(tls_private_key.automated) > 0 ? 1 : 0
}

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "vcradler-test-sec-group"
  description = "Sec Group for testing"
  vpc_id      = data.aws_vpc.main.id

  ingress_cidr_blocks = [var.my_ip]
  ingress_rules       = ["http-80-tcp", "https-443-tcp", "ssh-tcp", "all-icmp"]
  egress_rules        = ["all-all"]
}

resource "aws_eip" "this" {
  vpc      = true
  instance = module.ec2-instance[count.index].id[0]
  count = 1
}

module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.19.0"
  name    = "${var.user}-test-repo"

  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = "t2.micro"
  subnet_id                   = tolist(data.aws_subnet_ids.all.ids)[0]
  vpc_security_group_ids      = [module.security_group.security_group_id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.personal_key[count.index].id


  depends_on = [
    aws_key_pair.personal_key
  ]
  count = 1
}

terraform {
  required_version = ">=0.12.29, <1.1"
  required_providers {
    aws = {
      version = "~> 3.10"
    }
  }
}