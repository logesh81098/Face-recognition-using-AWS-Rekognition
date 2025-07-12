variable "ami-id" {
  default = "ami-0953476d60561c955"
}

variable "instance-type" {
  default = "t3.medium"
}

variable "security-group" {
  default = {}
}

variable "iam-instance-profile" {
  default = {}
}

variable "keypair" {
  default = {}
}

variable "subnet" {
  default = {}
}

variable "root-volume-type" {
  default = "gp3"
}

variable "root-volume-size" {
  default = "12"
}