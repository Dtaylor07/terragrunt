provider "aws" {
  
}

resource "aws_vpc" "atlantis-vpc" {
  cidr_block = "10.7.0.0/16"
}