####################################################################################################################################################################################
#                                                               Security Group
####################################################################################################################################################################################

#Security Group of EC2 instance 

resource "aws_security_group" "jenkins-servers-sg" {
  name = "Face-Rekognition-Jenkins-server-SG"
  description = "Security Group for Face Rekognition Jenkins server"
  vpc_id = var.vpc-id

  ingress {
    description = "Ingress Rule for SSH to connect fom anywhere"
    from_port = var.SSH-port
    to_port = var.SSH-port
    cidr_blocks = [var.anywhere-cidr]
    protocol = "tcp"
  }

  ingress {
    description = "Ingress Rule for HTTP to connect fom anywhere"
    from_port = var.HTTP-port
    to_port = var.HTTP-port
    cidr_blocks = [var.anywhere-cidr]
    protocol = "tcp"
  }

  ingress {
    description = "Ingress Rule for HTTPS to connect fom anywhere"
    from_port = var.HTTPS-port
    to_port = var.HTTPS-port
    cidr_blocks = [var.anywhere-cidr]
    protocol = "tcp"
  }

  ingress {
    description = "Ingress Rule for Jenkins to connect fom anywhere"
    from_port = var.Jenkins-port
    to_port = var.Jenkins-port
    cidr_blocks = [var.anywhere-cidr]
    protocol = "tcp"
  }

  ingress {
    description = "Ingress Rule for Face Rekongition Application to connect fom anywhere"
    from_port = var.Application-port
    to_port = var.Application-port
    cidr_blocks = [var.anywhere-cidr]
    protocol = "tcp"
  }

  egress {
    from_port = 0
    to_port = 0
    cidr_blocks = [var.anywhere-cidr]
    protocol = "-1"
  }

  tags = {
    Name = "Face-Rekognition-SG"
    Project = "Recognizing-faces-using-AWS-Rekognition-service"
  }
}