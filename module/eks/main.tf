##########################################################################################################################################
#                                                        EKS Cluster    
##########################################################################################################################################

#Face Rekognition EKS Cluster

resource "aws_eks_cluster" "face-rekognition-cluster" {
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
  cluster_name = aws_eks_cluster.face-rekognition-cluster.name
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

####################################################################################################################################################################################
#Attaching service account to K8S cluster so that Application can able to connect with AWS Services

data "aws_eks_cluster" "face-rekognition-cluster-data" {
  name = "Face-Rekognition-Cluster"
  depends_on = [ aws_eks_cluster.face-rekognition-cluster ]
}

###################################################################################################################################################################################
#                                                        EKS OpenID Provider
##################################################################################################################################################################################

#Creating OpenID connect provider, So that Containers in Pod in EKS Cluster can able to access AWS services

resource "aws_iam_openid_connect_provider" "face-rekognition-openid-connect-provider" {
  url = data.aws_eks_cluster.face-rekognition-cluster-data.identity[0].oidc[0].issuer
  client_id_list = ["sts.amazonaws.com"]
}

