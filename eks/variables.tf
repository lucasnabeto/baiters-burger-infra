variable "cluster_name" {
  type        = string
  description = "Nome do cluster EKS"
}

variable "k8s_version" {
  type        = string
  default     = "1.31"
  description = "Versão do Kubernetes"
}

variable "node_instance_type" {
  type        = string
  default     = "t2.medium"
  description = "Tipo de instância para os nós do EKS"
}

variable "desired_capacity" {
  type        = number
  default     = 1
  description = "Quantidade desejada de nós"
}

variable "min_size" {
  type        = number
  default     = 1
  description = "Quantidade mínima de nós"
}

variable "max_size" {
  type        = number
  default     = 2
  description = "Quantidade máxima de nós"
}

variable "role_name" {
  type        = string
  description = "IAM Role existente para o cluster"
  default     = "LabRole"
}

variable "region" {
  type        = string
  default     = "us-east-1"
  description = "Região AWS"
}
