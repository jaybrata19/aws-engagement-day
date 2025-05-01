resource "aws_vpc" "custom-vpc" {
  cidr_block       = var.cidr_blocks["vpc"]
  instance_tenancy = "default"
  tags = {
    Name = "custom-vpc"
  }
}

resource "aws_subnet" "subnet-a" {
  vpc_id            = aws_vpc.custom-vpc.id
  cidr_block        = var.cidr_blocks["subnet_a"]
  availability_zone = var.availability_zone["zone_a"]
  tags = {
    Name = "custom-vpc-subnet-a"
  }
}

resource "aws_subnet" "subnet-b" {
  vpc_id            = aws_vpc.custom-vpc.id
  cidr_block        = var.cidr_blocks["subnet_b"]
  availability_zone = var.availability_zone["zone_b"]

  tags = {
    Name = "custom-vpc-subnet-b"
  }
}

resource "aws_internet_gateway" "custom-gw" {
  vpc_id = aws_vpc.custom-vpc.id

  tags = {
    Name = "custom-vpc-ig"
  }
}

resource "aws_default_route_table" "custom-rt" {
  route {
    cidr_block = var.cidr_blocks["route_table"]
    gateway_id = aws_internet_gateway.custom-gw.id
  }
  default_route_table_id = aws_vpc.custom-vpc.default_route_table_id
}