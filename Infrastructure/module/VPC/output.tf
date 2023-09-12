output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "subnet_ids" {
  value = values(aws_subnet.subnets).*.id
  # value = ${aws_subnet.subnets.*.id}

}

output "igw_id" {
  value = aws_internet_gateway.igw.id
}

output "rt_id" {
  value = aws_route_table.rt.id
}

output "security_group_ids" {
  value = values(aws_security_group.security_group).* [0].id
}

