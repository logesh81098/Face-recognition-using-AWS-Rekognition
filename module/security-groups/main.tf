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


####################################################################################################################################################################################
#                                                               Security Group
####################################################################################################################################################################################

#Security Group of EKS Cluster

resource "aws_security_group" "eks-cluster-sg" {
  name = "Face-Rekognition-EKS-Cluster-SG"
  description = "Security Group for Face Rekognition EKS Cluster"
  vpc_id = var.vpc-id

  ingress {
    description = "Ingress Rule for EKS cluster to communicate API Server fom anywhere"
    from_port = var.API-Server
    to_port = var.API-Server
    cidr_blocks = [ var.anywhere-cidr]
    protocol = "tcp"
  }

  ingress {
    description = "Ingress Rule for Flask Application Port"
    from_port = var.Application-port
    to_port = var.Application-port
    cidr_blocks = [ var.anywhere-cidr]
    protocol = "tcp"
  }

  egress {
    from_port = 0
    to_port = 0
    cidr_blocks = [var.anywhere-cidr]
    protocol = "-1"
  }

  tags = {
    Name = "Face-Rekognition-EKS-Cluster-SG"
    Project = "Recognizing-faces-using-AWS-Rekognition-service"
    "kubernetes.io/cluster/Face-Rekognition-Cluster" = "owned"
    "eks-cluster-name" = "Face-Rekognition-EKS-Cluster"
  }
}


####################################################################################################################################################################################
#                                                               Security Group
####################################################################################################################################################################################

#Security Group of EKS NodeGroup

resource "aws_security_group" "eks-nodegroup-sg" {
  name = "Face-Rekognition-EKS-NodeGroup-SG"
  description = "Security Group for Face Rekognition EKS NodeGroup"
  vpc_id = var.vpc-id

  ingress {
    description = "Ingress Rule for EKS cluster to communicate API Server fom anywhere"
    from_port = var.API-Server
    to_port = var.API-Server
    cidr_blocks = [ var.anywhere-cidr]
    protocol = "tcp"
  }

  ingress {
    description = "Ingress Rule for Flask Application Port"
    from_port = var.Application-port
    to_port = var.Application-port
    cidr_blocks = [ var.anywhere-cidr]
    protocol = "tcp"
  }

  ingress {
    from_port = "0"
    to_port = "65535"
    protocol = "tcp"
    self = true
    description = "Allow All Traffic from self"
  }
  
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    security_groups = [ aws_security_group.eks-cluster-sg.id ]
    description = "Allow all traffic from EKS cluster SG"
  }

  egress {
    from_port = 0
    to_port = 0
    cidr_blocks = [var.anywhere-cidr]
    protocol = "-1"
  }

  tags = {
    Name = "Face-Rekognition-EKS-NodeGroup-SG"
    Project = "Recognizing-faces-using-AWS-Rekognition-service"
    "kubernetes.io/cluster/Face-Rekognition-Cluster" = "owned"
    "eks-cluster-name" = "Face-Rekognition-EKS-Cluster"
  }
}