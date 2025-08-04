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

# Module 1 - Inline module definition
module "local_module" {
  source = "./modules/local"
  version = "v1.0.0"
}

# Module 2 - Inline module definition
module "test_module" {
  source = "./modules/test"
  version = "v2.0.0"
}

# Module 3 - Inline module definition
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

# Create the module directories and files automatically
resource "null_resource" "create_modules" {
  triggers = {
    timestamp = timestamp()
  }

  provisioner "local-exec" {
    command = <<-EOT
      mkdir -p modules/local modules/test modules/demo
      echo 'resource "random_pet" "local_pet" { length = 2 }' > modules/local/main.tf
      echo 'resource "random_string" "test_string" { length = 8 }' > modules/test/main.tf
      echo 'resource "null_resource" "demo_resource" { triggers = { timestamp = timestamp() } }' > modules/demo/main.tf
    EOT
  }
}
