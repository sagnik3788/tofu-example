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

# ✅ Valid module from the registry with full context
module "label_module" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  context = {
    namespace             = "example"
    environment           = "dev"
    stage                 = "test"
    name                  = "app"
    attributes            = ["web"]
    delimiter             = "-"
    enabled               = true
    tags                  = {}
    additional_tag_map    = {}
    label_order           = []
    regex_replace_chars   = "/[^a-zA-Z0-9]/"
    id_length_limit       = null
  }
}

# ✅ Random pet generator
resource "random_pet" "name" {
  length = 4
}

# ✅ Triggers on random pet output
resource "null_resource" "demo" {
  triggers = {
    generated_name = random_pet.name.id
  }
}
