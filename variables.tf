variable "ingress_public_subnet" {
  description = "ingress rule for public subnet "
  type = list(object({
    from_port = number
    to_port   = number
    protocol = string
  }))

  default = [{
    from_port = 22
    to_port   = 22
    protocol = "tcp"
  }]
}


# variable "ingress_private_subnet_1" {
#   description = "ingress rule for public subnet "
#   type = list(object({
#     from_port       = number
#     to_port         = number
#     cidr_blocks     = string
#     security_groups = string
#   }))


# }