This repo is to allow for creation of EC2 resources in a test environment to reproduce issues with the Gremlin agent on Windows.
It was tested/created with `opentofu` but should also work with Terraform proper.

It creates network configuration according to these docs:

https://www.gremlin.com/docs/getting-started-install-virtual-machine
https://www.gremlin.com/docs/platform-integrations-webhooks

This code will provide the RDP password in plaintext as an output. This is extremely not good for anything but testing environments; if you didn't already know that don't use this repo for creating resources. 
In order to decrypt the password, you will need to provide a valid path to the keypair (keypair_name) which is currently hardcoded in the output 'rdp_password' in the 'file' function call. 

Usable variables are:

"ticket_num" (to tie resources to a specific ticket/reference/use case)

"aws_region" 

"number_of_instances" (optional, defaults to 1)

"os" (needs to be either windows_2019(default) or windows_2016)

"instance_type" (optional, defaults to t3a.medium)

"keypair_name" (ssh keypair for encrypting the RDP password for the created instance)

Potential TODO items:

Create user data to install the Gremlin agent on Windows using powershell

If you would like to configure your s3 backend (e.g., terraform init -backend-config="s3_backend.conf") , add a s3_backend.conf file with the following values:
    bucket = "s3-bucket-name"
    key    = "path-to-state"
    region = "us-east-1"

