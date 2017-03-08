variable "aws_region" {
  default = "us-east-1"
}

variable "project_name" {
  description = "Application name"
}

variable "instance_type" {
  description = "AWS instance type"
  default = "t2.nano"
}

variable "vpc_id" {
  description = "The VPC for resources"
}

variable "subnets" {
  type = "list"
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
  default = 2
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

variable "tags" {
  type = "map"
  description = "tags to add to resources"
  default = {}
}