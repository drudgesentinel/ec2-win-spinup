resource "aws_ec2_managed_prefix_list" "gremlin_API_and_webhooks" {
  name           = "All Gremlin API/Webhook/Health IP Addresses"
  address_family = "IPv4"
  max_entries    = 6

  entry {
    cidr        = "75.2.112.174/32"
    description = "Gremlin API"
  }

  entry {
    cidr        = "99.83.220.149/32"
    description = "Gremlin API"
  }

  entry {
    cidr        = "44.236.227.116/32"
    description = "Webhook/Health"
  }

  entry {
    cidr        = "54.186.237.228/32"
    description = "Webhook/Health"
  }

  entry {
    cidr        = "44.239.162.49/32"
    description = "Webhook/Health"
  }

  entry {
    cidr        = "44.240.200.121/32"
    description = "Webhook/Health"
  }
}

resource "aws_security_group" "baremetal_gremlin" {
  name        = "Baremetal Gremlin"
  description = "Minimum required permissions per AWS VPC docs"

  tags = {
    created_by = data.aws_caller_identity.current.arn
    ticket_num = var.ticket_num
  }
}

resource "aws_vpc_security_group_ingress_rule" "ssh_inbound" {
  security_group_id = aws_security_group.baremetal_gremlin.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 22
  to_port     = 22
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "gremlin_outbound" {
  security_group_id = aws_security_group.baremetal_gremlin.id
  prefix_list_id    = aws_ec2_managed_prefix_list.gremlin_API_and_webhooks.id
  ip_protocol       = -1
}

