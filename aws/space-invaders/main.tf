module "website_bucket" {
  source      = "../modules/website"
  bucket_name = "space-invaders"
  error_page  = "index.html"
  home_page   = "index.html"
  tags = {
    website     = "space-invaders"
    environment = "prod"
  }
}

resource "null_resource" "run_script" {
  provisioner "local-exec" {
    command = "aws s3 sync s3://space-invaders-source s3://${module.website_bucket.name}"
  }
}

# resource "aws_s3_object" "index_html" {
#   bucket = module.website_bucket.name
#   key    = "index.html"
#   source = "s3://${module.website_bucket.name}/index.html"
#   acl    = "public-read"
# }


# Create the Network
module "vpc" {
  source = "../modules/vpc"
}

# Create the Security Groups
module "sec-groups" {
  source = "../modules/sg"
  # Passed from VPC Module
  vpc_id = module.vpc.vpc_id
}

# Create the Load Balancer
module "load-balancer" {
  source = "../modules/loadbalancer"

  # Passed from VPC Module
  subnet_a_id = module.vpc.subnet_a_id
  subnet_b_id = module.vpc.subnet_b_id

  # Passed from Sec Groups Module
  allow_http_id = module.sec-groups.security_group_ids.allow_http
}

# Create the Autoscaling Group
module "autoscaling-group" {
  source = "../modules/asg"

  region         = var.region
  startup_script = "install_space_invaders.sh"

  image_id = {
    us-east-1 = "ami-058a8a5ab36292159",
    us-east-2 = "ami-058a8a5ab36292159"
  }

  instance_type      = "t2.micro"
  instance_count_min = 2
  instance_count_max = 10
  add_public_ip      = true

  # Passed from VPC Module
  subnet_a_id = module.vpc.subnet_a_id
  subnet_b_id = module.vpc.subnet_b_id

  # Passed from Sec Groups Module
  allow_http_id = module.sec-groups.security_group_ids.allow_http
  allow_ssh_id  = module.sec-groups.security_group_ids.allow_ssh

  # Passed from Load Balancer Module
  load_balancer_id = module.load-balancer.load_balancer_id
}