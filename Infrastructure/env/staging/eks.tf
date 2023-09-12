

module "EKS" {
  source = "../../module/EKS"
  # name_master             = var.name_master
  # name_worker = var.name_worker
  # name_autoscaler-policy  = var.name_autoscaler-policy
  # name_worker-new-profile = var.name_worker-new-profile
  name_role_woker = var.name_role_woker
  name_eks        = var.name_eks
  node_group_name = var.node_group_name
  capacity_type   = var.capacity_type
  disk_size       = var.disk_size
  instance_types  = var.instance_types
  ec2_ssh_key     = var.ec2_ssh_key
  subnet_ids      = module.VPC.subnet_ids
  sg_id           = [module.VPC.security_group_ids]
}
