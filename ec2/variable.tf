variable "project" {
  description = "The AWS Project Name."
  type        = string
}

variable "owner" {
  type        = string
  default     = "jk"
  description = "Owner of the Infrastructure"
}

variable "region" {
  type        = string
  default     = "us-east-2"
  description = "The AWS region name which you are using to deploy the AWS resources"
}

variable "ami" {
  type        = string
  description = "AMI which will be used for spinning up the instance"
}

variable "instance_type" {
  type        = string
  description = "Instance Type for the EC2 instance (t2.micro, t2.small etc.)"
}

variable "ingress_rules" {
  description = "List of ingress rules for the security group"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"] # Allow SSH from anywhere
    }
  ]
}

variable "egress_rules" {
  description = "List of egress rules for the security group"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}
