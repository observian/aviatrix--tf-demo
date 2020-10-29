variable "aws_region" {
  default = "us-west-2"
}

variable "zones" {
  description = "AZ map by region"
  default = {
    us-west-2-alpha   = "us-west-2a"
    us-west-2-bravo   = "us-west-2b"
    us-west-2-charlie = "us-west-2c"
    us-east-1-alpha   = "us-east-1a"
    us-east-1-bravo   = "us-east-1b"
    us-east-1-charlie = "us-east-1c"
  }
}

variable "application" {
  default = "aviatrix-controller"
}
variable "env" {
  default = "hub"
}

variable "vpc_cidr" {
  description = "CIDR block for aviatrix-controller vpc"
}

variable "public_alpha_cidr" {
  description = "CIDR block for public subnet alpha"
}

# variable "private_alpha_cidr" {
#   description = "CIDR block for private subnet alpha"
# }

variable "public_bravo_cidr" {
  description = "CIDR block for public subnet bravo"
}

# variable "private_bravo_cidr" {
#   description = "CIDR block for private subnet bravo"
# }

variable "keypair" {
  default     = "aviatrix"
}

variable "admin_pw" {
}

variable "admin_email" {
  default = "kyle+aviatrixdemotf@observian.com"
}

variable "aws_access_name" {
  default = "observian-lab-account"
}