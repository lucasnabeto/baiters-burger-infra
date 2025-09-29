data "aws_iam_role" "lab_role" {
  name = "LabRole"
}

data "aws_s3_object" "lambda_authorize_code" {
  bucket = "baitersburger-lambda-code"
  key    = "lambda-function.zip"
}