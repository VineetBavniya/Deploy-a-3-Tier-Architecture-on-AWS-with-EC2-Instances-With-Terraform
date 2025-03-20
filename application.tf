resource "aws_security_group" "application_instance_sg" {
  vpc_id     = aws_vpc.main.id
  depends_on = [aws_security_group.presentation_instance_sg]
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.presentation_instance_sg.id]
  }
  ingress {
    from_port       = 3200
    to_port         = 3200
    protocol        = "tcp"
    security_groups = [aws_security_group.presentation_instance_sg.id]
  }
  ingress {
    from_port       = -1
    to_port         = -1
    protocol        = "icmp"
    security_groups = [aws_security_group.presentation_instance_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

data "template_cloudinit_config" "init_1" {
  gzip          = false
  base64_encode = true

  part {
    filename     = "git.sh"
    content_type = "text/x-shellscript"
    content      = file("${path.module}/git.sh")
  }

  part {
    filename     = "node.sh"
    content_type = "text/x-shellscript"
    content      = file("${path.module}/node.sh")
  }

}



resource "aws_instance" "application_instance" {
  ami           = "ami-05b10e08d247fb927"
  instance_type = "t2.micro"
  key_name      = "projectO"
  subnet_id       = aws_subnet.private_subnet_1.id
  security_groups = [aws_security_group.application_instance_sg.id]
  user_data = data.template_cloudinit_config.init_1.rendered
  tags = {
    Name = "application_instance "
  }

  depends_on = [aws_security_group.application_instance_sg, aws_vpc.main]
}