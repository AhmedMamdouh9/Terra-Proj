resource "aws_subnet" "my_subnet" {
  count = length(var.cider_subnet)
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = var.cider_subnet[count.index]
  availability_zone = var.availability_zone[count.index]

  tags = {
    Name = var.subnet_name[count.index]
  }
}
