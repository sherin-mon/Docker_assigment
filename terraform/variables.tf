variable "region" {
  default = "us-east-1"
}

variable "project" {
  default = "NimbusKart"
}

variable "environment" {
  default = "staging"
}

variable "owner" {
  default = "Sherin"
}

variable "vpc_cidr" {
  default = "10.20.0.0/16"
}

variable "ssh_cidr" {
  default = "0.0.0.0/0"
}
