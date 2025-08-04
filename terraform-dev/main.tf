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

# Real registry modules that actually exist
module "label_module" {
  source  = "cloudposse/label/null"
  version = "0.25.0"
  
  context = {
    namespace   = "example"
    environment = "dev"
    stage       = "test"
    name        = "app"
    attributes  = ["web"]
    delimiter   = "-"
    enabled     = true
  }
}

module "docker_container" {
  source  = "kreuzwerker/docker"
  version = "3.0.0"
}

module "random_pet" {
  source  = "hashicorp/random"
  version = "3.5.0"
}

# Your existing resources
resource "random_pet" "name" {
  length = 4
}

resource "null_resource" "demo" {
  triggers = {
    generated_name = random_pet.name.id
  }
}
