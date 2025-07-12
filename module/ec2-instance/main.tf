####################################################################################################################################################################################
#                                                                     EC2 instance
####################################################################################################################################################################################

#EC2 instance to create docker container image of Face Rekognition application and push it to docker hub

resource "aws_instance" "rekognition-jenkins-server" {
  ami = var.ami-id
  instance_type = var.instance-type
  subnet_id = var.subnet
  vpc_security_group_ids = [var.security-group]
  key_name = var.keypair
  iam_instance_profile = var.iam-instance-profile
  ebs_block_device {
    volume_size = var.root-volume-size
    volume_type = var.root-volume-type
    device_name = "/dev/xvda"
  }
  tags = {
    Name = "Face-Rekognition-Jenkins-Server"
  }
}