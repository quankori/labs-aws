variable "cidr_public_subnet" {
  type    = string
  default = "10.11.13.0/24"
}

variable "cidr_private_subnet" {
  type    = string
  default = "10.11.12.0/24"
}

variable "cidr_vpc" {
  type    = string
  default = "10.32.0.0/16"
}

variable "cidr_route" {
  type    = string
  default = "0.0.0.0/0"
}

variable "aws_region" {
  type    = string
  default = "ap-southeast-1"
}

variable "project_name" {
  type    = string
  default = "prj"
}

variable "project_env" {
  type    = string
  default = "dev"
}
