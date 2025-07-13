variable "vpc-id" {
  default = {}
}

variable "anywhere-cidr" {
  default = "0.0.0.0/0"
}

variable "SSH-port" {
  default = "22"
}

variable "HTTP-port" {
  default = "80"
}

variable "HTTPS-port" {
  default = "443"
}

variable "Jenkins-port" {
  default = "8080"
}

variable "Application-port" {
  default = "81"
}

variable "API-Server" {
  default = "443"
}