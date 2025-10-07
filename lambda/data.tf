data "aws_iam_role" "lab_role" {
  name = "LabRole"
}

data "aws_s3_object" "lambda_authorizer_code" {
  bucket = "baiters-burger-infra"
  key    = "lambdas/lambda_authorizer.zip"
}

data "aws_s3_object" "lambda_user_password_code" {
  bucket = "baiters-burger-infra"
  key    = "lambdas/lambda_user_password.zip"
}