variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

/* variable "vpc_cidr" {
  default = "10.0.0.0/20" # private CIDRs : https://en.wikipedia.org/wiki/Private_network
} */
  

variable "app_name" {
  default = "JollyHR"
}
