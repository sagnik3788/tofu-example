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

# Registry modules with versions
module "random_pet_module" {
  source  = "hashicorp/random"
  version = "3.5.0"
}

module "random_string_module" {
  source  = "hashicorp/random"
  version = "3.6.0"
}

module "null_resource_module" {
  source  = "hashicorp/null"
  version = "3.2.0"
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
