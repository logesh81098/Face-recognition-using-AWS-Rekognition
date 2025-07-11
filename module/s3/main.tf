####################################################################################################################################################################################
#                                                                          S3 Bucket
####################################################################################################################################################################################

#Photos of celebrities that will be fed into the artificial intelligence system will be kept in this S3 bucket

resource "aws_s3_bucket" "source-bucket" {
  bucket = "face-rekognition-source-bucket"
  tags = {
    Name = "face-rekognition-source-bucket"
    Project = "Recognizing-faces-using-AWS-Rekognition-service"
  }
}