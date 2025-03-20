resource "aws_security_group" "data_instance_sg" {
  vpc_id = aws_vpc.main.id
  depends_on = [ aws_security_group.application_instance_sg   ]
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.application_instance_sg.id]
  }
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.application_instance_sg.id]
  }
  ingress {
    from_port       = -1
    to_port         = -1
    protocol        = "icmp"
    security_groups = [aws_security_group.application_instance_sg.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}


resource "aws_instance" "data_instance" {
  ami           = "ami-05b10e08d247fb927"
  instance_type = "t2.micro"
  key_name      = "projectO" // change key name 
  subnet_id       = aws_subnet.private_subnet_2.id
  security_groups = [aws_security_group.data_instance_sg.id]
  user_data = file("datascript.sh")
  tags = {
    Name = "data_instance"
  }

  depends_on = [aws_security_group.data_instance_sg, aws_vpc.main]
}