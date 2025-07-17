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



###################################################################################################################################################################################
#                                                        IAM Role
##################################################################################################################################################################################

#IAM Role for Service Account 

resource "aws_iam_role" "rekognition_irsa_role" {
  name = "Rekognition-IRSA-Role"
  description = "IAM Role for Service Account"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Federated = aws_iam_openid_connect_provider.face-rekognition-openid-connect-provider.arn
        },
        Action = "sts:AssumeRoleWithWebIdentity",
        Condition = {
          StringEquals = {
            "oidc.eks.us-east-1.amazonaws.com/id/73F2CF662342DD5E19ACBF3EF48C904F:sub": "system:serviceaccount:default:face-rekognition-sa"
          }
        }
      }
    ]
  })
}


#[Note: We might required to change the OIDC ARN eacg time for new creation on line 91] 


##########################################################################################################################################
#                                                   IAM Policy
##########################################################################################################################################

#IAM Policy for OpenID connect provider

resource "aws_iam_policy" "rekognition-openid-connect-provider-policy" {
  name = "Rekognition-IRSA-Policy"
  description = "IAM Policy for for OpenID-Connect-Provider"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "CloudWatchLogGroup",
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": "arn:aws:logs:*:*:*"
        },
        {
            "Sid": "DynamoDBGetItems",
            "Effect": "Allow",
            "Action": [
                "dynamodb:*"
            ],
            "Resource": "arn:aws:dynamodb:*:*:*"
        },
        {
            "Sid": "RekognitionIndexFace",
            "Effect": "Allow",
            "Action": [
                "rekognition:*"
            ],
            "Resource": "*"
        },
        {
            "Sid": "S3PutSourceImage",
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket",
                "s3:PutObject",
                "s3:GetObject",
                "s3:HeadObject"
            ],
            "Resource": [
                "arn:aws:s3:::face-rekognition-source-bucket/*",
                "arn:aws:s3:::face-rekognition-source-bucket"
            ]
        }
    ]

}  
EOF
  tags = {
    Name = "Rekognition-IRSA-Policy"
    Project = "Recognizing-faces-using-AWS-Rekognition-service"
  }
}


##########################################################################################################################################
#                                                        Role Policy Attachement
##########################################################################################################################################

#Attaching Role and Policy

resource "aws_iam_role_policy_attachment" "eks-irsa" {
  role = aws_iam_role.rekognition_irsa_role.id
  policy_arn = aws_iam_policy.rekognition-openid-connect-provider-policy.arn
}