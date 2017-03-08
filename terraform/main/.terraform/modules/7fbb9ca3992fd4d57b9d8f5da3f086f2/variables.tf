variable "cloudwatch_logs_arn" {
  type = "string"
}

variable "name" {
  description = "name for policy attachment"
}

variable "role" {
  description = "The name of the role to attach the policy to"
}