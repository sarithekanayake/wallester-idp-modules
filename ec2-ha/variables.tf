variable "unique_name" {
  description = "Environment/Project name"
  type = string
}
variable "vpc_id" {
    description = "VPC ID"
    type = string
}
variable "private_subnet_ids" {}
variable "public_subnet_ids" {}
variable "sg_elb_id" {}
variable "instance_type" {}
variable "desired_capacity" {}
variable "max_size" {}
variable "min_size" {}
variable "tg_arn" {}