terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.2"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.9"
    }
    external = {
      source  = "hashicorp/external"
      version = "~> 2.1"
    }
  }
}

resource "null_resource" "setup_environment" {
  provisioner "local-exec" {
    command = "echo Setting up environment... > setup.log"
  }
}

resource "time_sleep" "wait_for_boot" {
  depends_on = [null_resource.setup_environment]
  create_duration = "5s"
}

resource "local_file" "config_file" {
  depends_on = [time_sleep.wait_for_boot]

  content  = "app_config=active\n"
  filename = "${path.module}/app_config.txt"
}

resource "external" "fake_status_check" {
  depends_on = [local_file.config_file]

  program = ["bash", "-c", "echo '{\"status\": \"ok\"}'"]
}

resource "null_resource" "final_step" {
  triggers = {
    config_hash = filesha256(local_file.config_file.filename)
    status = external.fake_status_check.result["status"]
  }

  provisioner "local-exec" {
    command = "echo Final step triggered with config and external status."
  }
}
