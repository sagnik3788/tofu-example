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

resource "random_pet" "name" {
  length = 2
}

resource "random_integer" "rand" {
  min = 1
  max = 100
}

resource "null_resource" "demo" {
  triggers = {
    generated_name = random_pet.name.id
    random_number  = random_integer.rand.result
  }

  provisioner "local-exec" {
    command = "echo Generated pet name: ${random_pet.name.id} with number ${random_integer.rand.result}"
  }
}

output "final_output" {
  value = "Pet: ${random_pet.name.id}, Number: ${random_integer.rand.result}"
}
