resource "aws_s3_bucket" "tf_state" {
    bucket          = "tf-state-2"
    force_destroy   = true


    tags = {
        Name        = "Terraform State"
        Environment = "dev"
    }
}