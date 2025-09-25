resource "aws_eip" "eip" {
  tags = {
    Name = "${var.unique_name}-eip"
  }
}


resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip.id
  subnet_id = aws_subnet.public[0].id

  tags = {
    Name = "${var.unique_name}-nat"
  }

  depends_on = [ aws_internet_gateway.igw ]
}