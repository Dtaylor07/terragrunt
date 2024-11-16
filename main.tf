provider "aws" {
  
}

resource "aws_vpc" "atlantis-vpc1" {
  cidr_block = "10.7.0.0/16"

  tags = {
    Name = "VPC1"
  }
}