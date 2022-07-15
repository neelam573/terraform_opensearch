resource "aws_subnet" "opensearch_publicsubnet" {
  vpc_id = var.vpc_id
  map_public_ip_on_launch = true
  cidr_block = var.public_subnets_cidr
  tags = {
    "Name" = var.publicsubnet_name  
    }
}


resource "aws_subnet" "opensearch_privatesubnet" {
  vpc_id = var.vpc_id
  cidr_block = var.private_subnets_cidr
  
  tags = {
    "Name" = var.privatesubnet_name  
    }
}

