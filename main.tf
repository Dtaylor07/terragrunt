provider "aws" {
  
}

resource "aws_vpc" "atlantis-vpc1" {
  cidr_block = "10.7.0.0/16"

  tags = {
    Name = "VPC2"
  }
}

resource "aws_s3_bucket" "example" {
  bucket = "my-tf-test-bucket-atlantis"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}