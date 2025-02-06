terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket-amazon-1"  # Change to match your S3 bucket
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-locks"
  }
}
