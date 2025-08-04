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

# Module 1 - Simple local module
module "local_module" {
  source = "./modules/local"
  version = "v1.0.0"
}

# Module 2 - Another local module
module "test_module" {
  source = "./modules/test"
  version = "v2.0.0"
}

# Module 3 - Third local module
module "demo_module" {
  source = "./modules/demo"
  version = "v3.0.0"
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
