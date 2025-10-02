module "cognito" {
  source = "./cognito"

  default_password      = "Cognito@123"
  cognito_domain_prefix = "baitersburger-app"
}

module "eks" {
  source = "./eks"

  cluster_name       = "baitersburger-cluster"
  node_instance_type = "t2.medium"
  desired_capacity   = 1
  min_size           = 1
  max_size           = 2
  role_name          = "LabRole"
  region             = "us-east-1"
}

module "lambda" {
  source = "./lambda"
}

module "rds" {
  source = "./rds"
}