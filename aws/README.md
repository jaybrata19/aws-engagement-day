# aws-engagement-day

# Deploying Space Invaders Game in S3 Bucking using Terraform

This repository contains Terraform configuration files to deploy an EC2 instance on AWS. The instance is set up with a security group allowing SSH access, and Terraform is installed on the instance using a user data script.


## Instructions

### Resources to be creted 
- **AutoScaling Group**: Automatically adjusts the number of EC2 instances in response to demand, ensuring optimal application performance and cost-efficiency.
- **Security Group**: Acts as a virtual firewall for your EC2 instances, controlling inbound and outbound traffic based on specified rules
- **Load Balancer**: Distributes incoming application traffic across multiple targets, such as EC2 instances, to enhance the availability and reliability of applications.
- **S3 Bucket**: A scalable storage resource in AWS used for storing and retrieving any amount of data at any time, often used for backup, archiving, and data distribution.
- **VPC**: A Virtual Private Cloud provides a logically isolated network environment in AWS where you can launch AWS resources with customizable network configurations.


### Directory Structure

- **aws/modules**: This folder contains the root module to create the aws resources. They are more generic and can be used for variaty of different applications
- **aws/space-invaders**: This is the main folder which is calling all the modules which is necessary to build the space invaders game.


### Step 1: Clone the Repository

Clone this repository to your local machine:

```bash
git clone https://github.com/jaybrata19/aws-engagement-day.git
cd aws-engagement-day/aws/space-invaders
```
```bash
terraform -v
```

### Step 2: Configure Variables
Edit the `terraform.tfvars` file to set the desired values for your deployment. Key variables include:
- **region**: The AWS region where the instance will be deployed.(`us-east-2`)

### Step 3: Initialize Terraform
Initialize Terraform to download necessary providers and set up the environment:
```bash
terraform init
```

### Step 4: Plan the Deployment

Review the changes Terraform will make to your AWS environment by executing:

```bash
terraform plan
```

### Step 5: Apply the Deployment

Apply the configuration to create the EC2 instance and associated resources by running:

```bash
terraform apply -auto-approve
```

### Step 6: Play the Game

- **1.**: After sucessful Apply it will provide Outputs:
For example:

```bash
load_balancer_addres = my-project-elb-xxxxx.<aws-region>.elb.amazonaws.com
```

- **2.**: Copy the Output URL and Past in you web-browser to play the game.

### Step 7: Destroy the Deployment

Destroy the configuration to remove the S3 bucket and associated resources by running:

```bash
terraform destroy -auto-approve
```