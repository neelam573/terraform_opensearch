

variable "vpc_id" {
  type = string
  
}

variable "public_subnets_cidr" {
  type        = string
  description = "public subnet cidr"
  
}

variable "publicsubnet_name" {
    description = "public subnet name"
    type = string
  
}

variable "private_subnets_cidr" {
     type        = string
  description = "private subnet cidr"

}

variable "privatesubnet_name" {
    description = "private subnet name"
    type = string
  
}