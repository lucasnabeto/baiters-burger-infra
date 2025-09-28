variable "default_password" {
  default     = "Cognito@123"
  description = "Default password for new users in AWS Cognito"
  type        = string
}

variable "cognito_domain_prefix" {
  description = "Prefixo de domínio único para o endpoint do Cognito."
  type        = string
}