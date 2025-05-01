# aws-engagement-day

# EC2 Instance Deployment with Terraform

This repository contains Terraform configuration files to deploy an EC2 instance on AWS. The instance is set up with a security group allowing SSH access, and Terraform is installed on the instance using a user data script.


## Instructions

### Step 1: Clone the Repository

Clone this repository to your local machine:

```bash
git clone https://github.com/jaybrata19/aws-engagement-day.git
cd aws-engagement-day/ec2
```

### Step 2: Initialize Terraform
Initialize Terraform to download necessary providers and set up the environment:
```bash
terraform init
```
### Step 3: Configure Variables
Edit the `terraform.tfvars` file to set the desired values for your deployment. Key variables include:

- **ami**: The Amazon Machine Image ID for the instance. Ensure this is valid for your chosen region.
- **instance_type**: The type of EC2 instance (e.g., `t2.micro`).
- **region**: The AWS region where the instance will be deployed.(`us-east-2`)
- **project**: A project name for tagging purposes.
- **owner**: Your name or identifier for tagging purposes.

### Step 4: Plan the Deployment

Review the changes Terraform will make to your AWS environment by executing:

```bash
terraform plan
```

### Step 4: Apply the Deployment

Apply the configuration to create the EC2 instance and associated resources by running:

```bash
terraform apply -auto-approve
```

### Step 5: Validate the EC2

- **1.**: Go to AWS console --> Ec2 --> Instance (check your instance-name with suffix `vm`)
- **2.**: To connect with ec2 machine select the instance from the console and the click on `Connect` on top right.
- **3.**: It will take you to connect to instance page, leave everything default and Click on `Connect` again. 
- **4.**: Once inside the mahcine up type 

```bash
terraform -v
```