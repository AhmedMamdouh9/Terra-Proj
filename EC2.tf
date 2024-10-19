resource "aws_instance" "instance" {
  count                       = 2
  ami                         = "ami-04a81a99f5ec58529"   # Ubuntu 22.04 AMI
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.my_subnet[0].id # Place in the first subnet
  security_groups             = [aws_security_group.sg.id]
  associate_public_ip_address = true
  key_name                    = "vockey"

  tags = {
    Name = var.instance_name[count.index]  # Use instance names from the list
  }
}
