variable "unique_name" {
  description = "Environment/Project name"
  type = string
}
variable "vpc_id" {
    description = "VPC ID"
    type = string
}
variable "public_subnet_ids" {}