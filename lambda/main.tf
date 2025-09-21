resource "aws_lambda_function" "baiters_lambda" {
  function_name = var.lambda_function_name
  role          = data.aws_iam_role.lab_role.arn
  runtime       = var.language_runtime
  handler       = var.handler_method

  s3_bucket        = data.aws_s3_object.lambda_code.bucket
  s3_key           = data.aws_s3_object.lambda_code.key
  source_code_hash = data.aws_s3_object.lambda_code.etag

  tags = {
    Application = "BaitersBurger"
  }
}