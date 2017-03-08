
variable "name_prefix" {
  description = "prefix for all resources"
}

variable "max_instance_count" {
  description = "maximum number of concurrent instances of this task"
  default = 1024
}

variable "min_instance_count" {
  description = "minimum number of concurrent instances of this task"
  default = 1
}

variable "scale_up_threshold" {
  description = "average cpu utilization at which to scale up"
  default = 80
}

variable "scale_down_threshold" {
  description = "average cpu utilization at which to scale down"
  default = 50
}

variable "asg_name" {
  description = "name of autoscaling group to apply scaling policies to"
}

variable "dynamic_scaling" {
  description = "Should this cluster scale dynamically (true | false)"
  default = "true"
}