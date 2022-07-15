output "public_ec2_private_ip" {
    value = aws_instance.public_ec2.private_ip
}