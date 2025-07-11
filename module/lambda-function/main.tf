####################################################################################################################################################################################
#                                                                      Archive Files
####################################################################################################################################################################################

#To Convert the Python file to Zip file

data "archive_file" "rekognition-collection-id" {
  type = "zip"
  source_dir = "module/lambda-function"
  output_path = "module/lambda-function/rekognition-collection-id.zip"
}


####################################################################################################################################################################################
#                                                                        Lambda Function
####################################################################################################################################################################################

#Lambda function to create Rekognition CollectionID 

resource "aws_lambda_function" "rekognition-collection-id" {
  function_name = "Rekognition-CollectionID"
  description = "Lambda Function to Create Rekognition CollectionID"
  filename = "module/lambda-function/rekognition-collection-id.zip"
  handler = "rekognition-collection-id.lambda_handler"
  runtime = var.runtime
  role = var.collectionid-role-arn
  timeout = 20
  tags = {
    Name = "Rekognition-CollectionID"
    Project = "Recognizing-faces-using-AWS-Rekognition-service"
  }
}


####################################################################################################################################################################################
#                                                                    Invoke Lambda Function
####################################################################################################################################################################################

#Invoke Lambda Function to create Collection ID

resource "aws_lambda_invocation" "rekognition-collection-id-invoke" {
  function_name = aws_lambda_function.rekognition-collection-id.function_name
  input = jsonencode({
    "collection_id" = "face-rekognition-collection"
  })
}

####################################################################################################################################################################################
#                                                                      Archive Files
####################################################################################################################################################################################

#To Convert the Python file to Zip file

data "archive_file" "python-script-to-zip" {
  type = "zip"
  source_dir = "module/lambda-function"
  output_path = "module/lambda-function/rekognition-faceprints"
}

####################################################################################################################################################################################
#                                                                        Lambda Function
####################################################################################################################################################################################

#Lambda function to generate Faceprints

resource "aws_lambda_function" "rekognition-faceprints" {
  function_name = "Rekognition-Faceprints"
  description = "Lambda function to generate Faceprints from Source images"
  filename = "module/lambda-function/rekognition-faceprints"
  role = var.rekognition-faceprints-role-arn
  handler = "rekognition-faceprints.lambda_handler"
  runtime = var.runtime
  timeout = 20
  tags = {
    Name = "Rekognition-Faceprints"
    Project = "Recognizing-faces-using-AWS-Rekognition-service"
  }
}