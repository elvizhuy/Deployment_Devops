
module "VPC" {
  source          = "../../module/VPC"
  cidr_block_vpc  = var.cidr_block_vpc
  Name_vpc        = var.Name_vpc
  subnets         = var.subnets
  Name_igw        = var.Name_igw
  Name_rt         = var.Name_rt
  security_groups = var.security_groups
}
