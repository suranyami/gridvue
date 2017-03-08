variable "aws_region" {
  description = "AWS region"
}

variable "name_prefix" {
  description = "Name to prefix all resources with"
}

variable "instance_type" {
  default = "t2.medium"
  description = "AWS instance type"
}

variable "min_instance_count" {
  description = "Min numbers of servers in cluster"
  default     = "1"
}

variable "max_instance_count" {
  description = "Max numbers of servers in cluster"
  default     = "8"
}

variable "desired_instance_count" {
  description = "Desired numbers of servers in cluster"
  default     = "1"
}

variable "vpc_id" {
  description = "The VPC for the cluster"
}

variable "subnets" {
  type = "list"
}

variable "tags" {
  type = "map"
  description = "tags to add to resources"
  default = {}
}