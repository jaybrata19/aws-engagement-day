resource "aws_security_group" "allow_http" {
  name        = "${var.project}-allow-http"
  description = var.security_groups["allow_http"].description
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.security_groups["allow_http"].ingress.from_port
    to_port     = var.security_groups["allow_http"].ingress.to_port
    protocol    = var.security_groups["allow_http"].ingress.protocol
    cidr_blocks = var.security_groups["allow_http"].ingress.cidr_blocks
    description = var.security_groups["allow_http"].ingress.description
  }

  egress {
    from_port   = var.security_groups["allow_http"].egress.from_port
    to_port     = var.security_groups["allow_http"].egress.to_port
    protocol    = var.security_groups["allow_http"].egress.protocol
    cidr_blocks = var.security_groups["allow_http"].egress.cidr_blocks
  }
}

resource "aws_security_group" "allow_ssh" {
  name        = "${var.project}-allow-ssh"
  description = var.security_groups["allow_ssh"].description
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.security_groups["allow_ssh"].ingress.from_port
    to_port     = var.security_groups["allow_ssh"].ingress.to_port
    protocol    = var.security_groups["allow_ssh"].ingress.protocol
    cidr_blocks = var.security_groups["allow_ssh"].ingress.cidr_blocks
    description = var.security_groups["allow_ssh"].ingress.description
  }

  egress {
    from_port   = var.security_groups["allow_ssh"].egress.from_port
    to_port     = var.security_groups["allow_ssh"].egress.to_port
    protocol    = var.security_groups["allow_ssh"].egress.protocol
    cidr_blocks = var.security_groups["allow_ssh"].egress.cidr_blocks
  }
}
