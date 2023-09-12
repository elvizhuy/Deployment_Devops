cidr_block_vpc = "10.0.0.0/16"
Name_vpc       = "HaiND55_mock"
Name_igw       = "HaiND55_mock"
Name_rt        = "HaiND55_mock"
subnets = {
  "subnet1" = {
    cidr_block              = "10.0.1.0/24"
    availability_zone       = "us-west-1b"
    map_public_ip_on_launch = true
  },
  "subnet2" = {
    cidr_block              = "10.0.32.0/24"
    availability_zone       = "us-west-1b"
    map_public_ip_on_launch = true
  },
  "subnet3" = {
    cidr_block              = "10.0.64.0/24"
    availability_zone       = "us-west-1c"
    map_public_ip_on_launch = true
  }

}

security_groups = {
  "security_group_allow_all" = {
    name        = "HaiND55_sg_allow_all"
    description = "Allow all security groups"
    ingress_rules = [
      {
        from_port        = 0
        to_port          = 0
        protocol         = "ALL"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
      }
    ]
  }

}
