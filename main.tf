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
  name         = "integracao_lambda"
  hash_key     = "Id"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "Id"
    type = "S"
  }


}

resource "aws_iam_role" "lambda_role" {
  name = "lambda_dynamodb_cloudwatch_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action   = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_dynamodb_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
}

resource "aws_iam_role_policy_attachment" "lambda_cloudwatch_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}

resource "aws_lambda_function" "my_lambda" {
  function_name    = "integracao_dynamo"
  filename         = "lambda_function.zip" 
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.13"
  role             = aws_iam_role.lambda_role.arn
  memory_size      = 128 
  timeout          = 30

  environment {
    variables = {
      DYNAMODB_TABLE = "integracao_lambda" 
    }
  }
}
