terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 4.16"
        }
    }
}


provider "aws" {
    region = var.location
}

resource "aws_ecr_repository" "flask_app_serverless" {
    name = "flask-app-serverless"
}