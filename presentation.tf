resource "aws_security_group" "presentation_instance_sg" {
  vpc_id = aws_vpc.main.id

  dynamic "ingress" {
    for_each = var.ingress_public_subnet
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_instance" "presentation_instance" {
  ami           = "ami-05b10e08d247fb927"
  instance_type = "t2.micro"
  key_name      = "projectO" // change key name 
  subnet_id       = aws_subnet.public_subnet.id
  security_groups = [aws_security_group.presentation_instance_sg.id]
  user_data = data.template_cloudinit_config.init.rendered
  tags = {
    Name = "presentation_instance "
  }

  depends_on = [aws_security_group.presentation_instance_sg, aws_vpc.main]
}


data "template_cloudinit_config" "init" {
  gzip          = false
  base64_encode = true

  part {
    filename     = "nginx.sh"
    content_type = "text/x-shellscript"
    content      = file("${path.module}/nginx.sh")
  }

  part {
    filename     = "node.sh"
    content_type = "text/x-shellscript"
    content      = file("${path.module}/node.sh")
  }

}
