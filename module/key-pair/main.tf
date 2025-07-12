####################################################################################################################################################################################
#                                                                          Key pair
####################################################################################################################################################################################

#Keypair for Face Rekognition Jenkins Server

resource "tls_private_key" "jenkins-server" {
  algorithm = "RSA"
  rsa_bits = 4096
}


resource "aws_key_pair" "face-rekognition-jenkins-server-keypair" {
  key_name = "Face-Rekognition-Jenkins-Server-Keypair"
  public_key = tls_private_key.jenkins-server.public_key_openssh
}

resource "local_file" "face-rekognition-jenkins-server-private-key" {
  filename = "Face-Rekognition-Jenkins-Server-private-key"
  content = tls_private_key.jenkins-server.private_key_openssh
}

