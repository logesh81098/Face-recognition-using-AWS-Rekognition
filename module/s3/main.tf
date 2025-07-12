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


####################################################################################################################################################################################
#                                                                    S3 to trigger lambda
####################################################################################################################################################################################

#Configuring S3 to trigger Lambda Function

resource "aws_s3_bucket_notification" "s3-trigger-lambda" {
  bucket = aws_s3_bucket.source-bucket.bucket
  lambda_function {
    lambda_function_arn = var.rekognition-faceprints-function-arn
    events = ["s3:ObjectCreated:*"]
  }
}