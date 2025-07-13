output "jenkins-server-sg" {
  value = aws_security_group.jenkins-servers-sg.id
}

output "eks-cluster-sg" {
  value = aws_security_group.eks-cluster-sg.id
}

output "eks-nodegroup-sg" {
  value = aws_security_group.eks-nodegroup-sg.id
}