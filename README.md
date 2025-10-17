# Cloud Platform Exercise

Terraform setup for AWS with ECS, S3, and CloudWatch.

## What it does

- Creates ECS cluster with Fargate
- Sets up S3 bucket with encryption
- Adds CloudWatch alarm for error monitoring
- Deploys a simple web app

## Setup

1. Copy terraform.tfvars.example to terraform.tfvars
2. Edit terraform.tfvars with your values
3. Run terraform commands

```bash
terraform init
terraform plan
terraform apply
```

## Variables

Edit terraform.tfvars:
```
aws_region = "us-west-2"
project_name = "exercise"
environment = "dev"
alarm_email = "your-email@example.com"
```

## Testing

```bash
cd tests
pip install -r requirements.txt
export S3_BUCKET_NAME=$(terraform output -raw s3_bucket_name)
python -m pytest test_s3_bucket.py -v
```

## Cleanup

```bash
terraform destroy
```