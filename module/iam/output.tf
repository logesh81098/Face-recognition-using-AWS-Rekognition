output "collectionid-role-arn" {
  value = aws_iam_role.collectionid-role.arn
}

output "rekognition-faceprints-role-arn" {
  value = aws_iam_role.rekognition-faceprints-role.arn
}

output "jenkins-server-instance-profile" {
  value = aws_iam_instance_profile.jenkins-server-instance-profile.name
}

output "eks-cluster-role-arn" {
  value = aws_iam_role.face-rekognition-cluster-role.arn
}

output "eks-nodegroup-arn" {
  value = aws_iam_role.face-rekognition-nodegroup-role.arn
}