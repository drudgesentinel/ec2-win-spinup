#source: https://github.com/guillermo-musumeci/terraform-aws-latest-ami/blob/master/Get-Latest-Windows-AMI.tf

# Get latest Windows Server 2019 AMI
data "aws_ami" "windows-2019" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["Windows_Server-2019-English-Full-Base*"]
  }
}

# Get latest Windows Server 2016 AMI
data "aws_ami" "windows-2016" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["Windows_Server-2016-English-Full-Base*"]
  }
}

# this is probably an apply time data source, which is not ideal
data "aws_caller_identity" "current" {}