resource "aws_cognito_user_pool" "user_pool_configuration" {
  name                     = "BaitersBurger_CognitoUserPool"
  auto_verified_attributes = []
  mfa_configuration        = "OFF"

  username_configuration {
    case_sensitive = false
  }

  password_policy {
    minimum_length = 8
  }
}

resource "aws_cognito_user_pool_client" "client" {
  name            = "ClienteTeste"
  user_pool_id    = aws_cognito_user_pool.user_pool_configuration.id
  generate_secret = false
}

resource "aws_cognito_user" "user" {
  username     = "77521398076"
  user_pool_id = aws_cognito_user_pool.user_pool_configuration.id

  password = var.default_password
}