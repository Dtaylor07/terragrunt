module "vpc-1" {
  source = "https://github.com/Dtaylor07/learn-terraform/blob/main/modules/vpc"

  vpc_cidr_block    = "10.7.17.0/24"
  subnet_cidr_block = "10.7.17.48/28"
  subnet_type       = "public"
  route-table-name  = "public-RT"
  igw-name          = "my-igw"
  vpc-name          = "vpc-module"
}

include {
    path = find_in_parent_folders()
}