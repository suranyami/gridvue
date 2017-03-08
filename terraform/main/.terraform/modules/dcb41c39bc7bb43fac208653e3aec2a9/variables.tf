variable "aws_region" {
  description = "AWS region"
}

variable "name_prefix" {
  description = "Name to prefix all resources with"
}

variable "tags" {
  type = "map"
  description = "tags to add to resources"
  default = {}
}

variable "vpc_id" {
  description = "The VPC for the cluster"
}

variable "instance_sg" {
  description = "The EC2 instance security group ID"
}

variable "subnets" {
  type = "list"
}

variable "port" {
  type = "string"
  description = "traffic port"
  default = 80
}

variable "internal" {
  description = "is this ALB internal?"
  type = "string"
  default = "false"
}

variable "health_check" {
  type = "map"
  description = "container health check config"
  default = {}
}
