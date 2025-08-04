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

# ✅ Valid registry module
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

# ✅ Valid random_pet resource
resource "random_pet" "name" {
  length = 4
}

# ✅ Valid null resource
resource "null_resource" "demo" {
  triggers = {
    generated_name = random_pet.name.id
  }
}
