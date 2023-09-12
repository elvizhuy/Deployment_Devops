
resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block_vpc
  tags = {
    Name = "${var.Name_vpc}_vpc"
  }
}

resource "aws_subnet" "subnets" {
  for_each = var.subnets

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = each.value.map_public_ip_on_launch
  tags = {
    Name = "${each.key}_HaiND55_mock"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.Name_igw}_igw"
  }
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${var.Name_rt}_rt"
  }
}

resource "aws_route_table_association" "rt_association" {
  for_each = aws_subnet.subnets

  subnet_id      = each.value.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_security_group" "security_group" {
  for_each = var.security_groups

  name_prefix = each.value.name
  description = each.value.description

  dynamic "ingress" {
    for_each = each.value.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  tags = {
    Name = each.key
  }
}

# module "eks" {
#   source     = "../EKS"
#   subnet_ids = aws_subnet.subnet[*].id
#   sg_ids     = aws_security_group.sg[*].id
# }
# module "eks" {
#   source     = "../EKS"
#   subnet_ids = .subnet_ids
#   sg_ids     = module.vpc.security_group_ids
# }
