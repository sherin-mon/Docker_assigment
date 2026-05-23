locals {

  common_tags = {

    Project     = var.project
    Environment = var.environment
    Owner       = var.owner
    ManagedBy   = "terraform"

  }

}

module "network" {

  source = "./modules/network"

  vpc_cidr = var.vpc_cidr

  tags = local.common_tags

}

resource "aws_security_group" "web" {

  name = "web-sg"

  vpc_id = module.network.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.common_tags

}

resource "aws_instance" "web" {

  count = 2

  ami = "ami-test"

  instance_type = "t3.micro"

  subnet_id = module.network.subnets[count.index]

  vpc_security_group_ids = [
    aws_security_group.web.id
  ]

  tags = merge(
    local.common_tags,
    {
      Role = "web"
    }
  )

}

resource "aws_s3_bucket" "logs" {

  bucket = "nimbus-staging-logs"

  tags = local.common_tags

}

resource "aws_s3_bucket_versioning" "versioning" {

  bucket = aws_s3_bucket.logs.id

  versioning_configuration {

    status = "Enabled"

  }

}

# Lifecycle configuration intentionally disabled
# LocalStack community edition times out

resource "aws_ebs_volume" "orphan" {

  availability_zone = "us-east-1a"

  size = 20

  tags = merge(
    local.common_tags,
    {
      Purpose = "janitor-test"
    }
  )

}
