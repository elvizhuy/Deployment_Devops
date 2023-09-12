variable "cidr_block_vpc" {
  type        = string
  description = ""
  default     = null
}

variable "Name_vpc" {
  type        = string
  description = ""

}

variable "subnets" {
  description = "Map of subnets to create"
  type = map(object({
    cidr_block              = string
    availability_zone       = string
    map_public_ip_on_launch = bool
  }))
  default = null
}


variable "Name_igw" {
  type        = string
  description = ""
  default     = null
}

variable "Name_rt" {
  type        = string
  description = ""
  default     = null
}

variable "security_groups" {
  description = "Map of security groups to create"
  type = map(object({
    name        = string
    description = string
    ingress_rules = list(object({
      from_port        = number
      to_port          = number
      protocol         = string
      cidr_blocks      = list(string)
      ipv6_cidr_blocks = list(string)
    }))
  }))
}
