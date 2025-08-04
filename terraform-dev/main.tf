terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
}

# Simple modules for testing DetermineVersions
module "test_module_1" {
  source  = "hashicorp/random"
  version = "3.5.0"
}

module "test_module_2" {
  source  = "hashicorp/random"
  version = "3.6.0"
}

module "test_module_3" {
  source  = "hashicorp/random"
  version = "3.7.0"
}

# Simple resource
resource "random_pet" "name" {
  length = 4
}
