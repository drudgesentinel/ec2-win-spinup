output "instance_id" {
  description = "ID of created RHEL instance"
  # this'll need to be fixed if I add a third OS
  value = var.os == "windows_2019" ? aws_instance.windows_2019_instance[0].id : aws_instance.windows_2016_instance[0].id
}

output "instance_public_ip" {
  description = "Public IP of created RHEL instance"
  value       = var.os == "windows_2019" ? aws_instance.windows_2019_instance[0].public_ip : aws_instance.windows_2016_instance[0].public_ip
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

output "rdp_password" {
  value = rsadecrypt("${var.os == "windows_2019" ? aws_instance.windows_2019_instance[0].password_data : aws_instance.windows_2016_instance[0].password_data
}", file("~/creds/${var.keypair_name}.pem") )
}
