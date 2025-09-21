resource "aws_apigatewayv2_api" "api-gtw" {
  name          = "baiters-burger-api-gateway"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_vpc_link" "vpc-link" {
  name               = "baiters-burger-vpc-link"
  security_group_ids = [data.aws_security_group.sg.id]
  subnet_ids         = data.aws_subnets.example.ids
}

data "aws_security_groups" "sg" {
  filter {
    name   = "group-name"
    values = ["default"]
  }

  filter {
    name   = "vpc-id"
    values = [data.vpc_id]
  }
}

data "" "vpc_id" {
  
}