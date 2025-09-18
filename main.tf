#module "api-gateway" {
#  source = "./api-gateway"
#}

#module "cognito" {
#  source = "./cognito"
#}

#module "eks" {
#  source = "./eks"
#}

#module "lambda" {
#  source = "./lambda"
#}

module "rds" {
  source = "./rds"
}