
resource "aws_instance" "vm" {
  ami           = var.ami
  instance_type = var.instance_type
  vpc_security_group_ids = [
    aws_security_group.allow_ssh.id
  ]
  # User data script to install Terraform
  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install -y yum-utils
    sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
    sudo yum -y install terraform
    terraform -v
  EOF


  tags = {
    Name  = "${var.project}-${var.owner}-vm"
    phase = "final"
  }
}
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = var.egress_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }
}
