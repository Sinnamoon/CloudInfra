resource "aws_vpc" "vpc_rds" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "vpc-rds"
  }
}

resource "aws_subnet" "public_subnet_rds" {
  vpc_id            = aws_vpc.vpc_rds.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "eu-west-3a"
}

resource "aws_subnet" "private_subnet_rds" {
  vpc_id            = aws_vpc.vpc_rds.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-west-3a"
}

resource "aws_subnet" "public_subnet_rds_b" {
  vpc_id            = aws_vpc.vpc_rds.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-west-3b"
}

resource "aws_subnet" "private_subnet_rds_b" {
  vpc_id            = aws_vpc.vpc_rds.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "eu-west-3b"
}


resource "aws_internet_gateway" "igw_public_rds" {
  vpc_id = aws_vpc.vpc_rds.id
}

resource "aws_eip" "eip_nat_rds" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat_priv_rds" {
  allocation_id = aws_eip.eip_nat_rds.id
  subnet_id     = aws_subnet.public_subnet_rds.id
}

resource "aws_route_table" "route_table_public_rds" {
  vpc_id = aws_vpc.vpc_rds.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_public_rds.id
  }
}

resource "aws_route_table_association" "route_table_association_public_rds" {
  subnet_id      = aws_subnet.public_subnet_rds.id
  route_table_id = aws_route_table.route_table_public_rds.id
}


resource "aws_route_table" "route_table_private_rds" {
  vpc_id = aws_vpc.vpc_rds.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_priv_rds.id
  }
}

resource "aws_route_table_association" "route_table_association_private_rds" {
  subnet_id      = aws_subnet.private_subnet_rds.id
  route_table_id = aws_route_table.route_table_private_rds.id
}
