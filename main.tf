module "s3" {
  source = "./module/s3"
  rekognition-faceprints-function-arn = module.lambda-function.rekognition-faceprints-function-arn
}

module "iam" {
  source = "./module/iam"
}

module "lambda-function" {
  source = "./module/lambda-function"
  collectionid-role-arn = module.iam.collectionid-role-arn
  rekognition-faceprints-role-arn = module.iam.rekognition-faceprints-role-arn
  source-bucket-arn =  module.s3.source-bucket-arn
}

module "dynamodb" {
  source = "./module/dynamodb"
}

module "vpc" {
  source = "./module/vpc"
}