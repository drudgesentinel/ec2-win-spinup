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

resource "aws_instance" "rhel_instance" {
  count         = var.os == "rhel" ? var.number_of_instances : 0
  ami           = data.aws_ami.redhat-linux.id
  instance_type = var.instance_type
  key_name      = var.keypair_name
  user_data = templatefile("rhel_rpm_bootstrap.sh", {
    rhel_version = var.rhel_version
  })
  tags = {
    created_by = data.aws_caller_identity.current.arn
    ticket_num = var.ticket_num
    Name       = "rhel-repro-${count.index + 1}"
  }
}

resource "aws_instance" "suse_instance" {
  count         = var.os == "suse" ? var.number_of_instances : 0
  ami           = data.aws_ami.suse-linux.id
  instance_type = var.instance_type
  key_name      = var.keypair_name
  user_data = templatefile("suse_rpm_bootstrap.sh", {
    suse_version = var.suse_version
  })
  tags = {
    created_by = data.aws_caller_identity.current.arn
    ticket_num = var.ticket_num
    Name       = "suse-repro-${count.index + 1}"
  }
}