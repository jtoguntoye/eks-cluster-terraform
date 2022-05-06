variable "region" {
  type = string
}

variable "cluster_name" {
    type = string
}

variable "name_prefix" {
type        = string
description = "Prefix to be used on each infrastructure object Name created in AWS."
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

variable "asg_instance_types" {
 type = list(string)
 description = "List of EC2 instance machine types for the EKS worker nodes"
 

}

variable "autoscaling_minimum_size_by_az" {
 type = number
 description = "Minimum number of EC2 instances per AZ to autoscale the EKS cluster" 
}

variable "autoscaling_maximum_size_by_az" {
  type = number
  description = "Maximum number of EC2 instances per AZ to autoscale the EKS cluster"
}

variable "admin_users" {
  type = list(string)
  description = "List of Kubernetes admins"
}

variable "developer_users" {
  type = list(string)
  description = "List of Kubernetes developers"
}

variable "autoscaling_average_cpu" {
  type        = number
description = "Average CPU threshold to autoscale EKS EC2 instances."
}

