output "cognito_token_endpoint" {
  description = "URL do endpoint para solicitar o token OAuth2."
  value       = "https://${aws_cognito_user_pool_domain.domain.domain}.auth.us-east-1.amazoncognito.com/oauth2/token"
}

output "cognito_client_id" {
  description = "Client ID"
  value       = aws_cognito_user_pool_client.machine_client.id
}