terraform {
  backend "s3" {
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5"
    }
  }

  required_version = "~> 1.6"
}

provider "aws" {
  region = var.aws_region
}

locals {
  gremlin_user_data = templatefile("${path.module}/gremlin_install.ps1.tftpl", {
    gremlin_config_b64 = filebase64(var.gremlin_config_path)
  })
}

resource "aws_instance" "windows_2019_instance" {
  count                       = var.os == "windows_2019" ? var.number_of_instances : 0
  ami                         = data.aws_ami.windows-2019.id
  instance_type               = var.instance_type
  key_name                    = var.keypair_name
  get_password_data           = true
  user_data                   = local.gremlin_user_data
  user_data_replace_on_change = true
  tags = {
    created_by = data.aws_caller_identity.current.arn
    ticket_num = var.ticket_num
    Name       = "windows2019-repro-${count.index + 1}"
  }
}

resource "aws_instance" "windows_2016_instance" {
  count                       = var.os == "windows_2016" ? var.number_of_instances : 0
  ami                         = data.aws_ami.windows-2016.id
  instance_type               = var.instance_type
  key_name                    = var.keypair_name
  get_password_data           = true
  user_data                   = local.gremlin_user_data
  user_data_replace_on_change = true
  tags = {
    created_by = data.aws_caller_identity.current.arn
    ticket_num = var.ticket_num
    Name       = "windows2016-repro-${count.index + 1}"
  }
}