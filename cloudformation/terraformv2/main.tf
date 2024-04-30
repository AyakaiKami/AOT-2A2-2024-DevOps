provider "aws" {
  region     = var.region
  access_key = #access_key
  secret_key = #secret_key
}

data "aws_secretsmanager_secret" "db_password" {
  name = var.db_password_secret_name
}

data "aws_secretsmanager_secret_version" "db_password" {
  secret_id = data.aws_secretsmanager_secret.db_password.id
} 

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "aws_db_subnet_group" "baza_de_date_subnet" {
  name       = "baza_de_date_subnet"
  subnet_ids = data.aws_subnets.default.ids

  tags = {
    Name = "Subnet baza de date"
  }
}

resource "aws_security_group" "rds" {
  name   = "baza_rds"
  vpc_id = data.aws_vpc.default.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Baza_rds"
  }
}

resource "aws_db_parameter_group" "pg_baza" {
  name   = "postgres"
  family = "postgres16"

  parameter {
    name  = "log_connections"
    value = "1"
  }
}

resource "aws_db_instance" "rds_final" {
  identifier             = "rdsa2"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  engine                 = "postgres"
  engine_version         = "16.1"
  username               = "elevA2"
  password               = jsondecode(data.aws_secretsmanager_secret_version.db_password.secret_string)["password"]
  db_subnet_group_name   = aws_db_subnet_group.baza_de_date_subnet.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  parameter_group_name   = aws_db_parameter_group.pg_baza.name
  publicly_accessible    = true
  skip_final_snapshot    = true
}
