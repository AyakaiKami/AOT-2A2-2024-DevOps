provider "aws" {
  region     = var.region
  access_key = #access_key
  secret_key = #secret_key
}

resource "tls_private_key" "cheie" {
  algorithm = "RSA"
  rsa_bits  = 4096
}


resource "aws_key_pair" "key_pair" {
  key_name   = var.key_name
  public_key = tls_private_key.cheie.public_key_openssh
}


resource "local_file" "private_key" {
  content  = tls_private_key.cheie.private_key_pem
  filename = var.key_name
}
resource "aws_security_group" "securitate" {
  name        = "securitate"
  description = "Security group for EC2"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "instanta_ec2" {
  ami                    = "ami-03c3351e3ce9d04eb"
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.key_pair.key_name
  vpc_security_group_ids = [aws_security_group.securitate.id]

  tags = {
    Name = "public_instance"
  }

  root_block_device {
    volume_size = 30
    volume_type = "gp2"
  }
}