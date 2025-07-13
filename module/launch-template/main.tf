##########################################################################################################################################
#                                                        Launch Template    
##########################################################################################################################################

#Face Rekognition Launch template

resource "aws_launch_template" "face-rekognition-launch-template" {
  name = "Face-Rekognition-Launch-Template"
  vpc_security_group_ids = [ var.application-sg, var.nodegroup-sg]
  key_name = var.key-name
  tag_specifications {
    resource_type = "instance"
    tags = {
        Name = "Face-Rekogntion-WorkerNodes"
        Project = "Recognizing-faces-using-AWS-Rekognition-service"
    }
  }
  tags = {
    Name = "Face-Rekognition-Launch-Template"
    Project = "Recognizing-faces-using-AWS-Rekognition-service"
    "eks:cluster-name" = "Face-Rekognition-Cluster"
    "eks-nodegroup-name" = "Face-Rekognition-NodeGroup"
  }
}