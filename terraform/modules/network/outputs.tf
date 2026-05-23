output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnets" {
  value = [
    aws_subnet.public_1.id,
    aws_subnet.public_2.id
  ]
}
