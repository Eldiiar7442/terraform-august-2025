resource "aws_vpc" "original" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "original" {
  vpc_id     = aws_vpc.original.id
  cidr_block = "10.0.1.0/24"
}

resource "aws_subnet" "original1" {
  vpc_id     = aws_vpc.original.id
  cidr_block = "10.0.2.0/24"
}

resource "aws_subnet" "original2" {
  vpc_id     = aws_vpc.original.id
  cidr_block = "10.0.3.0/24"
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.original.id
 
}

resource "aws_route_table" "r" {
  vpc_id = aws_vpc.original.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.original.id
  route_table_id = aws_route_table.r.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.original1.id
  route_table_id = aws_route_table.r.id
}

resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.original2.id
  route_table_id = aws_route_table.r.id
}