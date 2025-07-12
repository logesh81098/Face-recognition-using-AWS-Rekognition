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


####################################################################################################################################################################################
#                                                                          IAM Role
####################################################################################################################################################################################

#IAM Role for Lambda function to generate faceprints from the source images store in S3 bucket

resource "aws_iam_role" "rekognition-faceprints-role" {
  name = "Rekognition-Faceprints-Role"
  description = "IAM Role for Lambda function to generate faceprints from the source images store in S3 bucket"
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
    Name = "Rekognition-Faceprints-Role"
    Project = "Recognizing-faces-using-AWS-Rekognition-service"
  }
}


####################################################################################################################################################################################
#                                                                          IAM Policy
####################################################################################################################################################################################

#IAM Policy for Lambda function to generate faceprints from the source images store in S3 bucket

resource "aws_iam_policy" "rekognition-faceprints-policy" {
  name = "Rekognition-Faceprints-Policy"
  description = "IAM Policy for Lambda function to generate faceprints from the source images store in S3 bucket"
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
      "Sid": "GetItemsFromS3Bucket",
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:HeadObject"
      ],
      "Resource": "arn:aws:s3:::face-rekognition-source-bucket/*"
    },
    {
      "Sid": "IndexFace",
      "Effect": "Allow",
      "Action": [
        "rekognition:IndexFaces"
      ],
      "Resource": "arn:aws:rekognition:*:*:collection/*"
    },
    {
      "Sid": "PutItemsinDynamoDBTable",
      "Effect": "Allow",
      "Action": [
        "dynamodb:PutItem"
      ],
      "Resource": "arn:aws:dynamodb:*:*:table/Faceprints-Table"
    }
  ]

}  
EOF
  tags = {
    Name = "Rekognition-Faceprints-Policy"
    Project = "Recognizing-faces-using-AWS-Rekognition-service"
  }
}


####################################################################################################################################################################################
#                                                                     IAM Role Policy Attachment
####################################################################################################################################################################################

resource "aws_iam_role_policy_attachment" "faceprints" {
  role = aws_iam_role.rekognition-faceprints-role.id
  policy_arn = aws_iam_policy.rekognition-faceprints-policy.arn
}


####################################################################################################################################################################################
#                                                                          IAM Role
####################################################################################################################################################################################

#IAM Role for Jenkins Server

resource "aws_iam_role" "jenkins-server-role" {
  name = "Rekognition-Jenkins-Server-Role"
  description = "IAM Role for Jenkins Server"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      }
    }
  ]
}  
EOF
  tags = {
    Name = "Rekognition-Jenkins-Server-Role"
    Project = "Recognizing-faces-using-AWS-Rekognition-service"
  }
}


####################################################################################################################################################################################
#                                                                          IAM Policy
####################################################################################################################################################################################

#IAM Policy for Jenkins Server

resource "aws_iam_policy" "jenkins-server-policy" {
  name = "Rekognition-Jenkins-Server-policy"
  description = "IAM Policy for Jenkins Server"
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
      "Sid": "FullAccessDynamoDB",
      "Effect": "Allow",
      "Action": [
        "dynamodb:*"
      ],
      "Resource": "arn:aws:dynamodb:*:*:*"
    },
    {
      "Sid": "RekognitionIndexFace",
      "Effect": "Allow",
      "Action": [
        "rekognition:*"
      ],
      "Resource": "*"
    },
    {
      "Sid": "S3PutSourceImage",
      "Effect": "Allow",
      "Action": [
        "s3:ListBucket",
        "s3:PutObject",
        "s3:GetObject",
        "s3:HeadObject"
      ],
      "Resource": [
        "arn:aws:s3:::face-rekognition-source-bucket/*",
        "arn:aws:s3:::face-rekognition-source-bucket"
      ]
    }
  ]

}  
EOF
  tags = {
    Name = "Rekognition-Jenkins-Server-Policy"
    Project = "Recognizing-faces-using-AWS-Rekognition-service"
  }
}


####################################################################################################################################################################################
#                                                                     IAM Role Policy Attachment
####################################################################################################################################################################################

resource "aws_iam_role_policy_attachment" "jenkins-server" {
  role = aws_iam_role.jenkins-server-role.id
  policy_arn = aws_iam_policy.jenkins-server-policy.arn
}


####################################################################################################################################################################################
#                                                                     IAM Instance Profile
####################################################################################################################################################################################

resource "aws_iam_instance_profile" "face-rekognition-jenkins-server" {
  name = "Rekognition-Flask-Application-Server-Role"
  role = aws_iam_role.jenkins-server-role.id
}