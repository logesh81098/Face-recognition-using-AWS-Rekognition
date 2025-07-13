##########################################################################################################################################
#                                                        EKS Cluster    
##########################################################################################################################################

#Face Rekognition EKS Cluster

resource "aws_eks_cluster" "eks-cluster" {
  name = "Face-Rekognition-Cluster"
  version = var.cluster-version
  role_arn = var.cluster-iam-role
  vpc_config {
    security_group_ids = [ var.cluster-sg ]
    subnet_ids = [ var.subnet-1, var.subnet-2 ]
  }
  tags = {
    Name = "Face-Rekogntion-Cluster"
    Project = "Recognizing-faces-using-AWS-Rekognition-service"
  }
}