
variable "cluster_name" {
  description = "cluster service runs in"
  type = "string"
}


variable "service_name" {
  description = "service to autoscale"
  type = "string"
}


variable "name_prefix" {
  description = "prefix for all resources"
}


variable "max_task_count" {
  description = "maximum number of concurrent instances of this task"
  default = 1024
}

variable "min_task_count" {
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


variable "dynamic_scaling" {
  description = "Should this cluster scale dynamically (true | false)"
  default = "true"
}