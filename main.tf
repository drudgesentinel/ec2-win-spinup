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

resource "aws_instance" "windows_2019_instance" {
  count         = var.os == "windows_2019" ? var.number_of_instances : 0
  ami           = data.aws_ami.windows-2019.id
  instance_type = var.instance_type
  key_name      = var.keypair_name
  tags = {
    created_by = data.aws_caller_identity.current.arn
    ticket_num = var.ticket_num
    Name       = "windows2019-repro-${count.index + 1}"
  }
}

resource "aws_instance" "windows_2016_instance" {
  count         = var.os == "windows_2016" ? var.number_of_instances : 0
  ami           = data.aws_ami.windows-2016.id
  instance_type = var.instance_type
  key_name      = var.keypair_name
  tags = {
    created_by = data.aws_caller_identity.current.arn
    ticket_num = var.ticket_num
    Name       = "windows2016-repro-${count.index + 1}"
  }
}