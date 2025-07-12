output "vpc-id" {
  value = aws_vpc.face-rekognition-vpc.id
}

output "subnet-1" {
  value = aws_subnet.face-rekognition-public-subnet-1.id
}