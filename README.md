# DevOps Assignment – Part A

## Overview

Terraform infrastructure deployment using LocalStack.

Infrastructure created:

- VPC (10.20.0.0/16)
- 2 Public Subnets
- Security Group
- 2 EC2 Instances
- S3 Bucket
- Orphan EBS Volume

## How to Run

Start LocalStack:

sudo docker run -d \
--name localstack \
-p 4566:4566 \
localstack/localstack:3.8.1

Run Terraform:

cd terraform

tflocal init

tflocal apply -auto-approve

## Outputs

bucket_name
subnet_ids
vpc_id

## Decisions & deviations

SSH access kept configurable.

S3 lifecycle disabled because LocalStack timed out.

Reusable network module used.

## AI usage disclosure

Used AI assistance for explanation and debugging.# Docker_assigment


## Part B – Cost Janitor

Implemented:

- Detect orphan EBS volumes
- Generate report.json
- Generate summary.md
- Support dry-run execution
- Skip deletion during analysis

Execution:

cd janitor

python janitor.py --dry-run

Sample Output:

[
 {
   "type":"orphan-ebs"
 }
]


## Part C – CI/CD

Implemented:

- GitHub Actions
- Terraform format check
- Terraform validation
- Python dependency installation
- Cost Janitor dry-run
