data "aws_vpc" "vpc_default" {
  default = true
}

data "aws_subnets" "nets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc_default.id]
  }
}


data "aws_secretsmanager_secret_version" "rds_credentials" {
  secret_id = aws_secretsmanager_secret.rds_credentials.id
}