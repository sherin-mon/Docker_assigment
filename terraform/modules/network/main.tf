resource "aws_vpc" "main" {

  cidr_block = var.vpc_cidr

  tags = merge(
    var.tags,
    {
      Name = "nimbus-vpc"
    }
  )
}

resource "aws_subnet" "public_1" {

  vpc_id = aws_vpc.main.id

  cidr_block = "10.20.1.0/24"

  availability_zone = "us-east-1a"

  tags = merge(
    var.tags,
    {
      Name = "public-subnet-1"
    }
  )
}

resource "aws_subnet" "public_2" {

  vpc_id = aws_vpc.main.id

  cidr_block = "10.20.2.0/24"

  availability_zone = "us-east-1b"

  tags = merge(
    var.tags,
    {
      Name = "public-subnet-2"
    }
  )
}
