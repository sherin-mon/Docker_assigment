output "vpc_id" {

  value = module.network.vpc_id

}

output "subnet_ids" {

  value = module.network.subnets

}

output "bucket_name" {

  value = aws_s3_bucket.logs.bucket

}
