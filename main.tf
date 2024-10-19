# provider "aws" {
#   region = "us-east-1"  # Change to your desired region
# }

# # Create a new VPC
# resource "aws_vpc" "my_vpc" {
#   cidr_block = "10.0.0.0/16"
#   enable_dns_support   = true
#   enable_dns_hostnames = true
#   tags = {
#     Name = "my-vpc"
#   }
# }

# # Create a public subnet in the first availability zone
# resource "aws_subnet" "public_subnet" {
#   vpc_id                  = aws_vpc.my_vpc.id
#   cidr_block              = "10.0.1.0/24"
#   map_public_ip_on_launch = true
#   availability_zone       = "us-east-1a"  

#   tags = {
#     Name = "public-subnet"
#   }
# }

# # Create a second public subnet in a different availability zone
# resource "aws_subnet" "public_subnet_2" {
#   vpc_id                  = aws_vpc.my_vpc.id
#   cidr_block              = "10.0.2.0/24"
#   map_public_ip_on_launch = true
#   availability_zone       = "us-east-1b"  # Second AZ

#   tags = {
#     Name = "public-subnet-2"
#   }
# }

# # Security Group for EC2 instances
# resource "aws_security_group" "ec2_sg" {
#   vpc_id = aws_vpc.my_vpc.id

#   ingress {
#     from_port   = 22  # Allow SSH
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]  # Adjust for specific IP ranges if needed
#   }

#   ingress {
#     from_port   = 80  # Allow HTTP
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "ec2-sg"
#   }
# }

# # Backend EC2 Instance
# resource "aws_instance" "backend" {
#   ami                  = "ami-04a81a99f5ec58529"  # Ubuntu 22.04 AMI (change as necessary)
#   instance_type        = "t2.micro"               # 1 core, 1 GB RAM
#   subnet_id            = aws_subnet.public_subnet.id
#   security_groups      = [aws_security_group.ec2_sg.id]  # Use ID instead of name
#   key_name             = "vockey"                 # Ensure this key pair exists in AWS

#   tags = {
#     Name = "Backend"
#   }

#   associate_public_ip_address = true

#   depends_on = [aws_security_group.ec2_sg]
# }

# # Frontend EC2 Instance
# resource "aws_instance" "frontend" {
#   ami                  = "ami-04a81a99f5ec58529"  # Ubuntu 22.04 AMI (change as necessary)
#   instance_type        = "t2.micro"               # 1 core, 1 GB RAM
#   subnet_id            = aws_subnet.public_subnet.id
#   security_groups      = [aws_security_group.ec2_sg.id]  # Use ID instead of name
#   key_name             = "vockey"                 # Ensure this key pair exists in AWS

#   tags = {
#     Name = "Frontend"
#   }

#   associate_public_ip_address = true

#   depends_on = [aws_security_group.ec2_sg]
# }

# # MySQL RDS Instance
# resource "aws_db_instance" "mysql" {
#   engine                   = "mysql"
#   engine_version           = "8.0"
#   instance_class           = "db.t3.micro"        # Lowest plan
#   allocated_storage         = 20                    # Minimum is 20 GB
#   db_name                  = "mydb"                # Use db_name instead of name
#   username                 = "admin"
#   password                 = "password123"         # Change to a secure password
#   db_subnet_group_name     = aws_db_subnet_group.my_db_subnet_group.name
#   vpc_security_group_ids   = [aws_security_group.ec2_sg.id]

#   skip_final_snapshot      = true

#   # Prevent exposure to the internet
#   publicly_accessible       = false
# }

# # DB Subnet Group
# resource "aws_db_subnet_group" "my_db_subnet_group" {
#   name       = "my-db-subnet-group"
#   subnet_ids = [aws_subnet.public_subnet.id, aws_subnet.public_subnet_2.id]

#   tags = {
#     Name = "my-db-subnet-group"
#   }
# }
