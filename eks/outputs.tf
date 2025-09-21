output "eks_cluster_name" {
  description = "Nome do cluster EKS"
  value       = aws_eks_cluster.this.name
}

output "eks_node_group_name" {
  description = "Nome do Node Group"
  value       = aws_eks_node_group.this.node_group_name
}

output "subnet_ids" {
  description = "IDs das subnets usadas pelo cluster"
  value       = data.aws_subnets.filtered.ids
}

output "kubeconfig_command" {
  description = "Comando para configurar o kubectl"
  value       = "aws eks update-kubeconfig --region ${var.region} --name ${aws_eks_cluster.this.name}"
}
