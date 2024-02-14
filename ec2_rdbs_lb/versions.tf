terraform {
    required_version = ">= 1.0"
    
    backend "s3" {
        bucket       = "tf-state"
        key          = "infra/terraform.tfstate"
        region       = "eu-central-1"
        encrypt      = true
    }
    required_providers {
        aws = {
            source      = "hashicorp/aws"
            version     = ">= 4.66"
        }
    }
}