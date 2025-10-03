resource "aws_db_subnet_group" "default" {
  name       = "rds-subnet-group"
  subnet_ids = data.aws_subnets.nets.ids
}

resource "aws_security_group" "rds_public" {
  name        = "rds-public-sg"
  description = "Allow public access to RDS"
  vpc_id      = data.aws_vpc.vpc_default.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "mysql" {
  identifier                          = "public-mysql"
  engine                              = "mysql"
  instance_class                      = "db.t3.micro"
  allocated_storage                   = 20
  username                            = local.rds_secret.username
  password                            = local.rds_secret.password
  db_subnet_group_name                = aws_db_subnet_group.default.name
  vpc_security_group_ids              = [aws_security_group.rds_public.id]
  publicly_accessible                 = true
  skip_final_snapshot                 = true
  iam_database_authentication_enabled = true
  db_name                             = local.rds_secret.db_name

  depends_on = [
    aws_secretsmanager_secret_version.rds_credentials_version
  ]
}

resource "aws_sns_topic" "rds_alerts" {
  name = "rds-alerts-topic"
}

resource "aws_sns_topic_subscription" "email_alert" {
  topic_arn = aws_sns_topic.rds_alerts.arn
  protocol  = "email"
  endpoint  = "alert@baitersburger.com.br"
}

resource "aws_cloudwatch_metric_alarm" "rds_cpu_high" {
  alarm_name          = "RDS-CPU-High"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = 300
  statistic           = "Average"
  threshold           = 70
  alarm_description   = "Alerta: CPU do RDS >= 70%"
  dimensions = {
    DBInstanceIdentifier = aws_db_instance.mysql.id
  }
  alarm_actions = [aws_sns_topic.rds_alerts.arn]
}

