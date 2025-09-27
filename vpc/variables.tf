variable "eks_name" {
  description = "EKS cluster name"
  type = string
}

variable "unique_name" {
  description = "Environment/Project name"
  type = string
}
variable "vpc_cidr_block" {
  description = "CIDR Range for VPC"
  type = string
}

variable "no_of_pri_subs" {
  description = "Number of private subnets need (Max. 3)"
  type = number
}

variable "no_of_pub_subs" {
  description = "Number of public subnets need (Max. 3)"
  type = number
}