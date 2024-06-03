variable "ticket_num" {
  type        = string
  description = "Optional Freshdesk ticket # associated with these resources"
  default     = ""
}

variable "aws_region" {
  type    = string
  default = "us-west-2"
}

variable "os" {
  type        = string
  default     = "rhel"
  description = "The operating system for your instance. Should be either 'rhel' or 'suse'"
}

variable "rhel_version" {
  type        = string
  description = "The RHEL major version (7-9) to install."
  default     = 9
  validation {
    condition     = var.rhel_version > 6 && var.rhel_version < 10
    error_message = "The RHEL versions should be between 7 and 9"
  }
}

variable "number_of_instances" {
  type        = number
  description = "The number of instances to deploy"
  default     = 1
  validation {
    condition     = var.number_of_instances > 0
    error_message = "The number of instances needs to be greater than zero"
  }
}

variable "suse_version" {
  type        = string
  description = "The SUSE major version to install (12 or 15)."
  default     = "15"
  validation {
    condition     = var.suse_version == "12" || var.suse_version == "15"
    error_message = "The SUSE version should be either 12 or 15"
  }

}

variable "instance_type" {
  type    = string
  default = "t3a.medium"
}

variable "keypair_name" {
  type        = string
  description = "This is the name of the region-specific ec2 keypair for accessing your instance"
}