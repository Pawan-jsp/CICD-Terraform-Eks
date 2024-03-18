variable "vpc_cidr" {
  description = "vpc cidr"
  type        = string

}

variable "public_subnets" {
  description = "public_subnets cidr"
  type        = list(string)

}

variable "instance_type" {
  description = "Instance Type"
  type        = string

}
