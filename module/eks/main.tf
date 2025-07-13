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
    Name = "Face-Rekognition-Cluster"
    Project = "Recognizing-faces-using-AWS-Rekognition-service"
  }
}


##########################################################################################################################################
#                                                        EKS Node Group   
##########################################################################################################################################

#EKS Node Group

resource "aws_eks_node_group" "face-rekognition-node-group" {
  cluster_name = aws_eks_cluster.eks-cluster.name
  node_group_name = "Face-Rekognition-NodeGroup"
  node_role_arn = var.nodegroup-role
  subnet_ids = [ var.subnet-1, var.subnet-2 ]
  scaling_config {
    max_size = 2
    min_size = 1 
    desired_size = 1
  }
  instance_types = [ var.instance-type ]
  launch_template {
    id = var.launch-template-id
    version = "$Latest"
  }
  tags = {
    Name = "Face-Rekogntion--NodeGroup"
    Project = "Recognizing-faces-using-AWS-Rekognition-service"
  }
  
}