variable "availability_zone" {
  description = "Availability zone for the subnets"
  type        = map(string)
  default = {
    zone_a = "us-east-2a"
    zone_b = "us-east-2b"
  }
}

variable "cidr_blocks" {
  description = "CIDR blocks for the VPC and subnets"
  type        = map(string)
  default = {
    vpc         = "10.0.0.0/16"
    subnet_a    = "10.0.1.0/24"
    subnet_b    = "10.0.2.0/24"
    route_table = "0.0.0.0/0"
  }
}