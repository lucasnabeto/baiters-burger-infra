variable "lambda_function_name" {
  default     = "BaitersBurgerLambda"
  description = "Name of the AWS Lambda function"
  type        = string
}

variable "language_runtime" {
  default     = "python3.13"
  description = "Required runtime for the AWS Lambda function execution"
  type        = string
}

variable "handler_method" {
  default     = "index.lambda_handler"
  description = "Entrypoint file name and method name of the AWS Lambda function"
  type        = string
}