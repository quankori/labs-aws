variable "cidr_subnet" {
  type    = string
  default = "10.0.0.0/16"
}

variable "availability_zones" {
  type    = string
  default = "us-east-1"
}

variable "cidr_vpc" {
  type    = string
  default = "10.0.0.0/16"
}

variable "subnet" {
  type    = string
  default = "10.0.16.0/24"
}

variable "aws_region" {
  type    = string
  default = "ap-southeast-1"
}
