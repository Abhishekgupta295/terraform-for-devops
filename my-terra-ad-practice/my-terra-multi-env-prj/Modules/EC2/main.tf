# private scope -> locals, doesnot change in run time

locals{
  key_name = var.env == "dev" ? "myterra-automate-key" : "myterra-automate-key-prod"
}



# Key Value Pair

resource "aws_key_pair" "terra-key" {
  key_name   = "${var.env}-terra-automate-key"
  # public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAJ8JR4SlOzVYAP087J8MC+tUupSIUXRTQhXXOoqPrws ubuntu@ip-172-31-35-99"
   # OR
  public_key = file("././terra-automate-key.pub")
}

# Default VPC

resource "aws_default_vpc" "default-vpc" {

}

# Security Group

resource "aws_security_group" "my_security_group" {
  name        = "${var.env}-terra-security-group"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_default_vpc.default-vpc.id
}

# Inbound & Outbound rules

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.my_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.my_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}


resource "aws_vpc_security_group_egress_rule" "allow_all_traffic" {
  security_group_id = aws_security_group.my_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

# EC2 instance

resource "aws_instance" "my_instance" {

    tags = {
       Name = "${var.env}-${var.ec2_instance_name}" # Instance Name
     }

    count = var.ec2_instance_count

    ami = var.ec2_ami_id # OS AMI ID

    instance_type = var.ec2_instance_type # Instance Type

    key_name = aws_key_pair.terra-key.key_name # Key pair

    vpc_security_group_ids = [aws_security_group.my_security_group.id] # VPC & Security Group

    # root storage (EBS)
    root_block_device {
        volume_size = var.ec2_root_volume_size
        volume_type = var.ec2_root_volume_type
    }
}

resource "aws_ec2_instance_state" "my_instance_state" {
  count       = length(aws_instance.my_instance)
  instance_id = aws_instance.my_instance[count.index].id
  state       = var.ec2_instance_state
}