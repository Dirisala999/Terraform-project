terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Data sources
data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_caller_identity" "current" {}

# VPC and Networking
module "vpc" {
  source = "./modules/vpc"

  project_name = var.project_name
  environment  = var.environment
  vpc_cidr     = var.vpc_cidr

  availability_zones = data.aws_availability_zones.available.names
}

# ECS Cluster and Services
module "ecs" {
  source = "./modules/ecs"

  project_name = var.project_name
  environment  = var.environment

  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  public_subnet_ids  = module.vpc.public_subnet_ids

  app_port       = var.app_port
  app_count      = var.app_count
  fargate_cpu    = var.fargate_cpu
  fargate_memory = var.fargate_memory

  depends_on = [module.vpc]
}

# S3 Bucket
module "s3" {
  source = "./modules/s3"

  project_name = var.project_name
  environment  = var.environment
}

# CloudWatch Alarm
module "cloudwatch_alarm" {
  source = "./modules/cloudwatch-alarm"

  project_name = var.project_name
  environment  = var.environment

  log_group_name = module.ecs.log_group_name
  email_address  = var.alarm_email
}
