provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "my_first_bucket"  # Replace with your desired bucket name
  acl    = "private"
}


resource "aws_lambda_function" "my_lambda" {
  function_name = "my-lambda-function"
  filename      = "my_lambda_function.zip"  # Replace with your Lambda function deployment package
  handler       = "lambda_function.handler"
  runtime       = "python3.8"
  
  role          = aws_iam_role.lambda_exec_role.arn

  

# IAM role for Lambda execution
resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action    = "sts:AssumeRole"
      }
    ]
  })
}

# Output the Lambda function ARN and S3 bucket name
output "lambda_arn" {
  value = aws_lambda_function.my_lambda.arn
}

output "s3_bucket_name" {
  value = aws_s3_bucket.my_bucket.bucket
}
