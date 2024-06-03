output "instance_id" {
  description = "ID of created RHEL instance"
  # this'll need to be fixed if I add a third OS
  value = var.os == "rhel" ? aws_instance.rhel_instance[0].id : aws_instance.suse_instance[0].id
}

output "instance_public_ip" {
  description = "Public IP of created RHEL instance"
  value       = var.os == "rhel" ? aws_instance.rhel_instance[0].public_ip : aws_instance.suse_instance[0].public_ip
}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}

output "caller_user" {
  value = data.aws_caller_identity.current.user_id
}

output "login_string" {
  value = "ssh -i ${var.keypair_name}.pem ec2-user@${var.os == "rhel" ? aws_instance.rhel_instance[0].public_ip : aws_instance.suse_instance[0].public_ip}"
}
