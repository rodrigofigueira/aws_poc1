terraform {
  required_version = "1.10.4"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.83.1"
    }
  }

}

provider "aws" {
  region = "us-east-1"
}

resource "aws_dynamodb_table" "dynamo_table" {
  name         = "MinhaTabela"
  hash_key     = "Id"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "Id"
    type = "S"
  }


}