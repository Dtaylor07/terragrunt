locals {
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl", "account.hcl"))
  account_id   = local.account_vars.locals.account_id
  admin_role   = local.account_vars.locals.admin_role
  read_role    = local.account_vars.locals.read_role

  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl", "region.hcl"))
  region      = local.region_vars.locals.region

  role = can(regex("arn:aws:iam::199660179115:root", get_aws_caller_identity_arn())) || can(regex("arn:aws:sts::199660179115:assumed-role/atlantis-role", get_aws_caller_identity_arn())) ? local.admin_role : local.read_role

  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl", "env.hcl"))
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
    provider "aws" {
    region = "${local.region}"
    allowed_account_ids = ["${local.account_id}"]
    assume_role {
    role arn = "arn:aws:iam::${local.account_id}:role/${local.role}"
    duration = "1h"
    }
    }
    EOF
}

generate "backend" {
  path     = "backend.tf"
  contents = <<EOF
    terraform {
        backend "s3" {
            bucket = "terragrunt-state-file"
            region = "us-east-1"
            encrypt = true
            key = "${path_relative_to_include()}/terraform.tfstate"

        }
    }
    EOF
}