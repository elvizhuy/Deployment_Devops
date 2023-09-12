

output "vpc_id" {
  value = module.VPC.vpc_id
}

output "subnet-id" {
  value = module.VPC.subnet_ids

}

output "rt_id" {
  value = module.VPC.rt_id
}

output "security_groups-id" {
  value = module.VPC.security_group_ids
}
