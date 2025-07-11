####################################################################################################################################################################################
#                                                                     Archive Files
####################################################################################################################################################################################

#To Convert the Python file to Zip file

data "archive_file" "rekognition-collection-id" {
  type = "zip"
  source_dir = "module/lambda-function"
  output_path = "module/lambda-function/rekognition-collection-id.zip"
}


####################################################################################################################################################################################
#                                                                     Lambda Function
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