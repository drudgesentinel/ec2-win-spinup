This repo is to allow for creation of EC2 resources to reproduce issues with the Gremlin agent.
It was tested/created with `opentofu` but should also work with Terraform proper.

It creates network configuration according to these docs:

https://www.gremlin.com/docs/getting-started-install-virtual-machine
https://www.gremlin.com/docs/platform-integrations-webhooks

If you choose RHEL 8, it will install extra kernel modules required for gremlin to function, otherwise it installs the listed RPM requirements from the linked docs.

`dnf` is very slow, so completion of the bootstrap script can take a long time after the instance itself is created.
I have configured the user data to print to the system log, you can view results at `/var/log/user-data.log`

You'll need to supply the os and keypair at minimum:
`terraform apply -var="os=suse" -var="keypair=my-keypair"`

Usable variables are:

"ticket_num" (to tie resources to a specific ticket/reference/use case)

"aws_region" 

"number_of_instances" (optional, defaults to 1)

"os" (needs to be either suse or rhel)

"rhel_version" (from 7-9. Specific point releases don't work.)
"suse_version" (12 or 15)

"instance_type" (optional, defaults to t3a.medium)

"keypair_name" (ssh keypair for accessing the created instance)

Potential TODO items:

Create a way to find more specific point releases and spin them up (at present, this grabs latest major version. Amazon doesn't own older versions so it might take some work to do this)

Add distributions (probably best accomplished by packaging up network/data sources as modules, and then using main to spin up the desired specific distro.)

Add a way to provide a config file directly for Gremlin so that it's not necessary to manually move it after provisioning an instance

If you would like to configure your s3 backend (e.g., terraform init -backend-config="s3_backend.conf") , add a s3_backend.conf file with the following values:
    bucket = "s3-bucket-name"
    key    = "path-to-state"
    region = "us-east-1"

