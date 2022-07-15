output "route_table" {
    value = [aws_route_table.public_routetable.id, aws_route_table.private_routetable.id]
  
}
