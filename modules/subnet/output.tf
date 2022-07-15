output "aws_subnet" {
    value = [aws_subnet.opensearch_publicsubnet.id, aws_subnet.opensearch_privatesubnet.id]
}