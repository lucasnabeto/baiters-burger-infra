variable "cognito_user_pool_id" {
  description = "User pool ID from Cognito module"
  type        = string
}

variable "cognito_machine_client_id" {
  description = "Machine client ID from Cognito module"
  type        = string
}

variable "cognito_login_client_id" {
  description = "Login client ID from Cognito module"
  type        = string
}

variable "cognito_login_client_secret" {
  description = "Login client secret from Cognito module"
  type        = string
}