# Assume que o Load Balancer (ELB) já foi criado pelo Kubernetes
# e que a sua ID e os security groups são conhecidos.
# Substitua os valores abaixo pelos seus dados.

variable "kubernetes_cluster_vpc_id" {
  description = "A ID da VPC onde o cluster Kubernetes está localizado."
  type        = string
}

variable "target_group_arn" {
  description = "O ARN do Target Group associado ao Load Balancer do Kubernetes."
  type        = string
}

variable "load_balancer_arn" {
  description = "O ARN do Load Balancer do Kubernetes."
  type        = string
}

# 1. Criação do VPC Link
# Este recurso é essencial para permitir que o API Gateway acesse o Load Balancer privado.
# resource "aws_apigatewayv2_vpc_link" "example_vpc_link" {
#   name = "example-http-api-vpc-link"
#     security_group_ids = [  ]
#     subnet_ids = [  ]
#   # O Target Groups ARN associado ao Load Balancer
#   target_arns = [var.target_group_arn]
# }

# 2. Configuração do API Gateway V2
# O recurso principal da API continua o mesmo.
resource "aws_apigatewayv2_api" "example_api" {
  name          = "example-http-api"
  protocol_type = "HTTP"
}

# 3. A Integração com o Backend (Load Balancer)
# O tipo de integração muda para "HTTP_PROXY".
# O endpoint agora aponta para o VPC Link.
resource "aws_apigatewayv2_integration" "example_integration" {
  api_id             = aws_apigatewayv2_api.example_api.id
  integration_type   = "HTTP_PROXY" # Tipo de integração para backends HTTP
  integration_method = "ANY"        # Permite qualquer método (GET, POST, etc.)
  connection_type    = "VPC_LINK"   # Conexão via VPC Link
  connection_id      = aws_apigatewayv2_vpc_link.example_vpc_link.id

  # O URI da integração aponta para o Load Balancer via o VPC Link
  # O formato é: {vpc_link_arn}/integrations/{id da integração}/{path}
  integration_uri = "${aws_apigatewayv2_vpc_link.example_vpc_link.arn}/"
}

# 4. A Rota
# A rota encaminha as requisições para a integração.
# Note que a rota agora é "ANY /{proxy+}" para encaminhar todas as requisições.
resource "aws_apigatewayv2_route" "example_route" {
  api_id    = aws_apigatewayv2_api.example_api.id
  route_key = "ANY /{proxy+}"
  target    = "integrations/${aws_apigatewayv2_integration.example_integration.id}"
}

# 5. O Stage
# Cria um "stage" (etapa de implantação) para a API.
resource "aws_apigatewayv2_stage" "example_stage" {
  api_id      = aws_apigatewayv2_api.example_api.id
  name        = "$default"
  auto_deploy = true
}

# Output para mostrar o URL da API após a implantação
output "api_gateway_url" {
  description = "O URL do API Gateway V2"
  value       = aws_apigatewayv2_stage.example_stage.invoke_url
}