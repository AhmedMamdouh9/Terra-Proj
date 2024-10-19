# DB Subnet Group
resource "aws_db_subnet_group" "my_db_subnet_group" {
  name       = "my-db-subnet-group"
  subnet_ids = aws_subnet.my_subnet[*].id

  tags = {
    Name = "MyDBSubnetGroup"
  }
}

# RDS Instance
resource "aws_db_instance" "my_rds" {
  identifier           = "my-mysql-db"
  engine               = "mysql"
  engine_version       = "8.0.39"
  instance_class       = "db.t3.micro"
  allocated_storage     = 20
  db_subnet_group_name = aws_db_subnet_group.my_db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.my_db_sg.id]

  username             = var.db_username
  password             = var.db_password
  skip_final_snapshot  = true 

  tags = {
    Name = "MyRDS"
  }
}
