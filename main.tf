#module "api-gateway" {
#  source = "./api-gateway"
#}

module "cognito" {
 source = "./cognito"

 default_password = "Cognito@123"
}

module "eks" {
  source             = "./eks"

  cluster_name       = "baitersburger-cluster"
  k8s_version        = "1.28"
  node_instance_type = "t2.medium"
  desired_capacity   = 1
  min_size           = 1
  max_size           = 2
  role_name          = "LabRole"
  region             = "us-east-1"
}

module "lambda" {
  source = "./lambda"

  language_runtime = "python3.13"
  handler_method   = "index.lambda_handler"
}

module "rds" {
  source = "./rds"
}