# main.tf
provider "aws" {
  region = var.aws_region      
}

resource "aws_s3_bucket" "example" {
  bucket = var.bucket_name     

  tags = {
    Name        = "Example bucket"
    Environment = var.environment  
  }
}

resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.example.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "example" {
  depends_on = [aws_s3_bucket_ownership_controls.example]

  bucket = aws_s3_bucket.example.id
  acl    = "private"
}
