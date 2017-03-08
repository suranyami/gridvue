
variable "environment_variables" {
  type = "map"
  default = {}
}

variable "name" {
  type = "string"
  description = "name to give task definition"
}

variable "image_url" {
  description = "container image uri"
}

variable "container_port" {
  description = "container http port"
  default = 3000
}

variable "container_name" {
  description = "name the container is known as"
  default = "main"
}

variable "cloudwatch_log_group" {
  description = "name of cloudwatch log group"
}

variable "cloudwatch_log_region" {
  description = "region of cloudwatch log group"
}

variable "memory_reservation" {
  type = "string"
  description = "minimum memory (in megabytes) required for this container"
  default = 64
}

variable "task_role_arn" {
  description = "ARN of role to apply to task"
  type = "string"
  default = ""
}