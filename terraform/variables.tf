variable "aws_region" {
  description = "Región AWS"
  type        = string
  default     = "us-east-1"
}

variable "debian_ami" {
  description = "AMI Debian 12"
  type        = string
  default     = "ami-0b0012dad04fbe3d7"
}

variable "instance_type" {
  description = "Tipo de instancia EC2"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Nombre del Key Pair"
  type        = string
  default     = "symfony-react"
}
