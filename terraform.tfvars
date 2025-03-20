ingress_public_subnet = [{
  from_port = 22
  to_port   = 22
  protocol = "tcp"
  },
  {
    from_port = 80
    to_port   = 80
    protocol = "tcp"
  },
  {
    from_port = 443
    to_port   = 443
    protocol = "tcp"
  },
  {
    from_port = -1
    to_port   = -1
    protocol = "icmp"
  }
]

# // for application instance 
# ingress_private_subnet_1 = [{
#   from_port       = 22
#   to_port         = 22
#   security_groups = "${aws_security_group.presentation_instance_sg.id}"
#   }, {
#   from_port       = 3200
#   to_port         = 3200
#   security_groups = "${aws_security_group.presentation_instance_sg.id}"
#   }
# ]