resource "aws_lambda_function" "baiters_lambda_authorizer" {
  function_name = "BaitersBurger-LambdaAuthorizer"
  role          = data.aws_iam_role.lab_role.arn
  runtime       = "nodejs18.x"
  handler       = "lambda-authorizer.handler"

  s3_bucket        = data.aws_s3_object.lambda_authorizer_code.bucket
  s3_key           = data.aws_s3_object.lambda_authorizer_code.key
  source_code_hash = data.aws_s3_object.lambda_authorizer_code.etag

  environment {
    variables = {
      COGNITO_USER_POOL_ID  = var.cognito_user_pool_id
      COGNITO_APP_CLIENT_ID = var.cognito_machine_client_id
      COGNITO_REGION        = "us-east-1"
    }
  }

  tags = {
    Application = "BaitersBurger"
  }
}

resource "aws_lambda_function" "baiters_lambda_user_password" {
  function_name = "BaitersBurger-LambdaCognito"
  role          = data.aws_iam_role.lab_role.arn
  runtime       = "nodejs18.x"
  handler       = "lambda-user-pass.handler"

  s3_bucket        = data.aws_s3_object.lambda_user_password_code.bucket
  s3_key           = data.aws_s3_object.lambda_user_password_code.key
  source_code_hash = data.aws_s3_object.lambda_user_password_code.etag

  environment {
    variables = {
      COGNITO_USER_POOL_ID      = var.cognito_user_pool_id
      COGNITO_APP_CLIENT_ID     = var.cognito_login_client_id
      COGNITO_APP_CLIENT_SECRET = var.cognito_login_client_secret
      COGNITO_REGION            = "us-east-1"
    }
  }

  tags = {
    Application = "BaitersBurger"
  }
}
