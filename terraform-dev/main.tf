terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }
}

# to test DetermineVersions 
module "web_server" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.0.0"
  
  instance_type = "t3.micro"
  name          = "web-server"
}

module "database" {
  source  = "terraform-aws-modules/rds/aws"
  version = "6.0.0"
  
  identifier = "my-db"
  engine     = "mysql"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"
  
  name = "my-vpc"
  cidr = "10.0.0.0/16"
}

# resources
resource "random_pet" "name" {
  length = 4
}

resource "null_resource" "demo" {
  triggers = {
    generated_name = random_pet.name.id
  }
}
