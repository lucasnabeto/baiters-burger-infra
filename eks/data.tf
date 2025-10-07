# VPC existente
data "aws_vpc" "existing" {
  filter {
    name   = "state"
    values = ["available"]
  }
}

# Subnets válidas para EKS
data "aws_subnets" "filtered" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.existing.id]
  }

  filter {
    name = "availability-zone"
    values = [
      "${var.region}a",
      "${var.region}b",
      "${var.region}c",
      "${var.region}d",
      "${var.region}f"
    ]
  }
}

# IAM Role existente
data "aws_iam_role" "eks_cluster_role" {
  name = var.role_name
}