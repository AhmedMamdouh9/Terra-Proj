variable "cider_range" {
  type = map
}

variable "vpc_name" {
  type = string
}

variable "cider_subnet" {
  type = list
}

variable "subnet_name" {
  type = list
}

variable "availability_zone" {
  type = list
}

variable "instance_type" {
  type = string
}

variable "instance_name" {
  type = list
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type = string
}
