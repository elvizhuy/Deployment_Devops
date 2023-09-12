
variable "subnet_ids" {
  description = "Danh sách ID của subnets"
  type        = list(string)

}

variable "sg_id" {
  description = "Danh sách ID của security groups"
  type        = list(string)

}



# variable "name_master" {
#   type        = string
#   description = ""
#   default     = null
# }

# variable "name_worker" {
#   type        = string
#   description = ""

# }

# variable "name_autoscaler-policy" {
#   type        = string
#   description = ""
#   default     = null
# }

# variable "name_worker-new-profile" {
#   type        = string
#   description = ""
#   # default     = null
# }

variable "name_role_woker" {
  type        = string
  description = ""

}
variable "name_eks" {
  type        = string
  description = ""
  default     = null
}

variable "node_group_name" {
  type        = string
  description = ""
  default     = null
}

variable "capacity_type" {
  type        = string
  description = ""
  default     = null
}

variable "disk_size" {
  type        = string
  description = ""
  default     = null
}

variable "instance_types" {
  type        = list(string)
  description = ""
  default     = null
}

variable "ec2_ssh_key" {
  type        = string
  description = ""
  default     = null
}
