variable "region" {
  type = string
}

variable "cluster_name" {
    type = string
}

variable "iac_environment_tag" {
    type = string
}

variable "main_vpc_cidr" {
    type = string 
}

variable "subnet_prefix_extension" {
type        = number
description = "CIDR block bits extension to calculate CIDR blocks of each subnetwork."
}

variable "zone_offset" {
  type = number
  description = "netnum value to ensure public subnet does not overlap with private subnet "
}