variable "project" {
  description = "The name of the current project."
  type        = string
  default     = "My Project"
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC to create the resources in."
}

variable "security_groups" {
  description = "Configuration for security groups"
  type = map(object({
    description = string
    ingress = object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
      description = string
    })
    egress = object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    })
  }))
  default = {
    allow_http = {
      description = "Enable HTTP Access"
      ingress = {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "HTTP Access"
      }
      egress = {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    }
    allow_ssh = {
      description = "Enable SSH Access"
      ingress = {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "SSH Access"
      }
      egress = {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    }
  }
}