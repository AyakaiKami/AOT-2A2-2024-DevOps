
provider "aws" {
  region     = "eu-north-1"
  access_key = #access_key
  secret_key = #secret_key
}

resource "aws_default_vpc" "default_vpc" {
  tags = {
    Name = "default vpc"
  }
}

data "aws_availability_zones" "available_zones" {}

resource "aws_default_subnet" "subnet_az1" {
  availability_zone = data.aws_availability_zones.available_zones.names[0]
}

resource "aws_default_subnet" "subnet_az2" {
  availability_zone = data.aws_availability_zones.available_zones.names[1]
}

resource "aws_security_group" "webserver_security_group" {
  name        = "webserver security group"
  description = "enable http access on port 80"
  vpc_id      = aws_default_vpc.default_vpc.id  

  ingress {
    description = "http access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "webserver_security_group"
  }
}

resource "aws_security_group" "database_security_group" {
  name        = "database security group"
  description = "Security group for PostgreSQL access"
  vpc_id      = aws_default_vpc.default_vpc.id

  ingress {
    description      = "PostgreSQL Inbound"
    from_port        = 5432
    to_port          = 5432
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]  # Consider narrowing this down for production environments
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "database_security_group"
  }
}

resource "aws_db_subnet_group" "database_subnet_group" {
  name       = "db-subnet-group"
  subnet_ids = [
    aws_default_subnet.subnet_az1.id,
    aws_default_subnet.subnet_az2.id
  ]
  description = "DB Subnet Group for RDS"

  tags = {
    Name = "db-subnet-group"
  }
}

resource "aws_db_instance" "db-instance" {
  engine                = "postgres"
  engine_version        = "12"
  multi_az              = false
  identifier            = "my-db-instance"
  username              = #username
  password              = #password
  instance_class        = "db.t3.micro"
  allocated_storage     = 20
  db_subnet_group_name  = aws_db_subnet_group.database_subnet_group.name
  vpc_security_group_ids = [aws_security_group.database_security_group.id]
  availability_zone     = data.aws_availability_zones.available_zones.names[0]
  db_name               = #name
  skip_final_snapshot   = true
  publicly_accessible   = true
}
