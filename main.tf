# Create access keys in aws cli cache
terraform {
  required_version = ">= 0.12"
}

data "external" "caller_id" {
  program = ["aws", "sts", "get-caller-identity", "--output", "json"]
}

# Fetch credentials from aws cli cache. Requires jq pkg
data "external" "aws_creds" {
  program    = ["jq", ".Credentials", "${pathexpand("~")}/${tolist(fileset(pathexpand("~"), ".aws/cli/cache/*.json"))[0]}"]
  depends_on = [data.external.caller_id]
}

provider "aws" {
  region     = var.aws_region
}


terraform {
  backend "s3" {
    bucket = "skyloop-jolly"
    key    = "tf-state/jolly"
    region = "us-east-1"
  }
}



provider "archive" {}

#
# Data sources for current AWS account ID, partition and region.
#

data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

data "aws_region" "current" {}

module "Cognito" {
  source  = "./modules/Cognito" 
}

module "lambda" {
  source = "./modules/lambda"
  
}

module "DB" {
  source = "./modules/DB"
}


module "API" {
  source = "./modules/API"
  aws_region = data.aws_region.current.name
  aws_account_id = data.aws_caller_identity.current.account_id
   depends_on = [
    module.lambda
  ]
 
}
