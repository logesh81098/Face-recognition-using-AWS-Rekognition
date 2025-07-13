variable "cluster-version" {
  default = "1.33"
}

variable "cluster-iam-role" {
  default = {}
}

variable "cluster-sg" {
  default = {}
}

variable "subnet-1" {
  default = {}
}

variable "subnet-2" {
  default = {}
}

variable "nodegroup-role" {
  default = {}
}

variable "instance-type" {
  default = "t3.medium"
}

variable "launch-template-id" {
  default = {}
}