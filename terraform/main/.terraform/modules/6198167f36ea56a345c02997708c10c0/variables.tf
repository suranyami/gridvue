variable "aws_region" {
  description = "AWS region"
}

variable "vpc_id" {
  description = "The VPC for resources"
}

variable "subnets" {
  type = "list"
  description = "Subnets for ALB"
}

variable "name" {
  description = "name for serice (and all subordinate resources)"
}

variable "cluster_name" {
  description = "cluster service runs in"
  type = "string"
}

variable "desired_task_count" {
  description = "desired number of concurrent instances of this task"
  default = 1
}

variable "instance_sg" {
  description = "The EC2 instance security group ID"
}

variable "max_task_count" {
  description = "maximum number of concurrent instances of this task"
  default = 1024
}

variable "min_task_count" {
  description = "minimum number of concurrent instances of this task"
  default = 1
}

variable "dynamic_scaling" {
  description = "Should this cluster scale dynamically (true | false)"
  default = "true"
}

variable "health_check" {
  type = "map"
  description = "container health check config"
  default = {}
}

variable "container_port" {
  description = "ALB target container port"
}

variable "container_name" {
  description = "name of the ALB target container"
}

variable "task_arn" {
  description = "ARN of task definition"
}