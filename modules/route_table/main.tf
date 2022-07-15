resource "aws_route_table" "public_routetable" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.internet_gateway
  }
  tags = {
    Name = var.route_public_name
  }
}

resource "aws_route_table_association" "public_route_table" {
  subnet_id      = var.opensearch_publicsubnet
  route_table_id = aws_route_table.public_routetable.id
}

resource "aws_route_table" "private_routetable" {
  vpc_id = var.vpc_id

  tags = {
    Name = var.route_private_name
  }
}

resource "aws_route_table_association" "private_route_table" {
  subnet_id      = var.opensearch_privatesubnet
  route_table_id = aws_route_table.private_routetable.id
}

resource "aws_route" "nat" {
  route_table_id         = aws_route_table.private_routetable.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = var.nat_gateway

}