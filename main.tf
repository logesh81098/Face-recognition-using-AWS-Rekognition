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

module "security-group" {
  source = "./module/security-groups"
  vpc-id = module.vpc.vpc-id
}

module "key-pair" {
  source = "./module/key-pair"
}

module "ec2-instance" {
  source = "./module/ec2-instance"
  subnet = module.vpc.subnet-1
  security-group = module.security-group.jenkins-server-sg
  keypair = module.key-pair.keypair
  iam-instance-profile = module.iam.jenkins-server-instance-profile
}

module "eks" {
  source = "./module/eks"
  cluster-iam-role = module.iam.eks-cluster-role-arn
  subnet-1 = module.vpc.subnet-1
  subnet-2 = module.vpc.subnet-2
  cluster-sg = module.security-group.eks-cluster-sg
  nodegroup-role = module.iam.eks-nodegroup-arn
  launch-template-id = module.launch-template.launch-template-id
}

module "launch-template" {
  source = "./module/launch-template"
  key-name = module.key-pair.keypair
  application-sg = module.security-group.jenkins-server-sg
  nodegroup-sg = module.security-group.eks-nodegroup-sg
}