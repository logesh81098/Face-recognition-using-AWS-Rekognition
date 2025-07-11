####################################################################################################################################################################################
#                                                                          IAM Role
####################################################################################################################################################################################

#IAM Role for Lambda function to create Rekognition CollectionID to generate Faceprints of celebrities sample photos 

resource "aws_iam_role" "collectionid-role" {
  name = "Rekognition-CollectionID-Role"
  description = "IAM Role for Lambda function to create Rekognition CollectionID to generate Faceprints of celebrities sample photos"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "lambda.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}  
EOF
  tags = {
    Name = "Rekognition-CollectionID-Role"
    Project = "Recognizing-faces-using-AWS-Rekognition-service"
  }
}


####################################################################################################################################################################################
#                                                                          IAM Policy
####################################################################################################################################################################################

#IAM Policy for Lambda function to create Rekognition CollectionID to generate Faceprints of celebrities sample photos 

resource "aws_iam_policy" "collectionid-policy" {
  name = "Rekognition-CollectionID-Policy"
  description = "IAM Policy for Lambda function to create Rekognition CollectionID to generate Faceprints of celebrities sample photos"
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
        "Sid": "CreateCollectionID",
        "Effect": "Allow",
        "Action": [
            "rekognition:CreateCollection",
            "rekognition:DeleteCollection",
            "rekognition:ListCollections"
        ],
        "Resource": "*"
    }
  ]
}  
EOF
  tags = {
    Name = "Rekognition-CollectionID-Policy"
    Project = "Recognizing-faces-using-AWS-Rekognition-service"
  }
}


####################################################################################################################################################################################
#                                                                     IAM Role Policy Attachment
####################################################################################################################################################################################

resource "aws_iam_role_policy_attachment" "collectionid" {
  role = aws_iam_role.collectionid-role.id
  policy_arn = aws_iam_policy.collectionid-policy.arn
}