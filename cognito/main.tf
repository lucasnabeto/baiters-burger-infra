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

resource "aws_cognito_user" "admin_user" {
  username     = "admin"
  user_pool_id = aws_cognito_user_pool.user_pool_configuration.id

  password = var.default_password
}

resource "aws_cognito_resource_server" "resource_server" {
  name         = "BaitersBurgerAPI"
  identifier   = "baitersburger"
  user_pool_id = aws_cognito_user_pool.user_pool_configuration.id

  scope {
    scope_name        = "api.read"
    scope_description = "Permission to read"
  }

  scope {
    scope_name        = "api.write"
    scope_description = "Permission to write"
  }
}

resource "aws_cognito_user_pool_client" "machine_client" {
  name         = "BaitersBurgerMachineClient"
  user_pool_id = aws_cognito_user_pool.user_pool_configuration.id

  generate_secret                      = true
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["client_credentials"]
  allowed_oauth_scopes = [
    "${aws_cognito_resource_server.resource_server.identifier}/api.read",
    "${aws_cognito_resource_server.resource_server.identifier}/api.write",
  ]
}

# resource "aws_cognito_user_pool_client" "login_client" {
#   name         = "BaitersBurgerLoginClient"
#   user_pool_id = aws_cognito_user_pool.user_pool_configuration.id

#   allowed_oauth_flows_user_pool_client = true
#   allowed_oauth_flows                  = ["code", "implicit"]
#   allowed_oauth_scopes = [
#     "openid",
#     "email",
#     "profile",
#     "${aws_cognito_resource_server.resource_server.identifier}/api.read",
#     "${aws_cognito_resource_server.resource_server.identifier}/api.write",
#   ]
#   explicit_auth_flows          = ["ALLOW_ADMIN_USER_PASSWORD_AUTH"]
#   supported_identity_providers = ["COGNITO"]
# }

resource "aws_cognito_user_pool_client" "login_client" {
  name         = "BaitersBurgerLoginClient"
  user_pool_id = aws_cognito_user_pool.user_pool_configuration.id

  # 1. Torna o cliente Confidencial (NECESSÁRIO para SECRET_HASH da sua Lambda)
  generate_secret = true

  # 2. REMOVIDAS as propriedades OAuth de redirecionamento que causaram o erro:
  # allowed_oauth_flows_user_pool_client = true 
  # allowed_oauth_flows                  = ["code", "implicit"]
  # (Comentadas ou removidas, elas não serão necessárias neste cliente)

  # 3. Adiciona o fluxo Admin necessário para a sua Lambda
  explicit_auth_flows = ["ALLOW_ADMIN_USER_PASSWORD_AUTH"]

  # A URL de Callback NÃO é necessária, pois não estamos usando redirecionamento OAuth!
  # callback_urls = [] 

  # Escopos ainda podem ser úteis se você usar client_credentials, mas para este fluxo, são opcionais.
  # allowed_oauth_scopes = [
  #   "${aws_cognito_resource_server.resource_server.identifier}/api.read",
  #   "${aws_cognito_resource_server.resource_server.identifier}/api.write",
  # ]
  supported_identity_providers = ["COGNITO"]
}

resource "aws_cognito_user_pool_domain" "domain" {
  domain       = var.cognito_domain_prefix
  user_pool_id = aws_cognito_user_pool.user_pool_configuration.id
}
