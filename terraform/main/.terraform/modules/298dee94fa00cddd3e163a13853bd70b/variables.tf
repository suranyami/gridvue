variable "aws_region" {
  description = "AWS region"
}

variable "vpc_id" {
  description = "The VPC for resources"
}

variable "subnets" {
  type = "list"
}

variable "name" {
  description = "name for service (and all subordinate resources)"
}

variable "cluster_name" {
  description = "cluster service runs in"
  type = "string"
}

variable "image_url" {
  description = "container image uri"
}

variable "container_port" {
  description = "container http port"
  default = 3000
}

variable "desired_task_count" {
  description = "desired number of concurrent instances of this task"
  default = 1
}

variable "environment_variables" {
  type = "map"
  default = {}
}

variable "instance_sg" {
  description = "The EC2 instance security group ID"
}

variable "instance_role" {
  description = "The EC2 instance role"
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

variable "memory_reservation" {
  type = "string"
  description = "minimum memory (in megabytes) required for this container"
  default = 64
}

variable "health_check" {
  type = "map"
  description = "container health check config"
  default = {}
}

variable "task_role_arn" {
  description = "ARN of role to apply to task"
  type = "string"
  default = ""
}