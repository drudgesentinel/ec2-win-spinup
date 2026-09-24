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
  default     = "windows_2019"
  description = "The operating system for your instance. Should be either 'rhel' or 'suse'"
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

variable "instance_type" {
  type    = string
  default = "t3a.medium"
}

variable "keypair_name" {
  type        = string
  description = "This is the name of the region-specific ec2 keypair for accessing your instance"
  default     = "gremlin-support-keypair"
}

variable "gremlin_config_path" {
  type        = string
  description = "Local path to the Gremlin agent config.yaml, written to C:\\ProgramData\\Gremlin\\Agent\\config.yaml on the instance"
  default     = "config.yaml"
}
