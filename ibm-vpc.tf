resource "aws_vpc" "ibm-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "IBM-VPC"
  }
}
resource "aws_subnet" "ibm_web_sn" {
  vpc_id     = aws_vpc.ibm-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-west-2a"

  tags = {
    Name = "ibm_web_subnet"
  }
}
resource "aws_subnet" "ibm_db_sn" {
  vpc_id     = aws_vpc.ibm-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-west-2b"

  tags = {
    Name = "ibm_databse_subnet"
  }
}
resource "aws_internet_gateway" "ibm_igw" {
  vpc_id = aws_vpc.ibm_vpc.id

  tags = {
    Name = "ibm_igw"
  }
}
resource "aws_route_table" "ibm_web_rt" {
  vpc_id = aws_vpc.ibm_vpc.id

  route - {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ibm_igw.id
  }

  tags = {
    Name = "ibm_web_routetable"
  }
}
resource "aws_route_table" "ibm_db_rt" {
  vpc_id = aws_vpc.ibm_vpc.id

  tags = {
    Name = "ibm_db_routetable"
  }
}
resource "aws_route_table_association" "ibm_web_rt_associate" {
  subnet_id      = aws_subnet.ibm_web_sn.id
  route_table_id = aws_route_table.ibm_web_rt.id
}
resource "aws_route_table_association" "ibm_db_rt_associate" {
  subnet_id      = aws_subnet.ibm_db_sn.id
  route_table_id = aws_route_table.ibm_db_rt.id
}
resource "aws_network_acl" "ibm_web_nacl" {
  vpc_id = aws_vpc.ibm_vpc.id

  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535
  }

  tags = {
    Name = "ibm_web_nacl"
  }
}
resource "aws_network_acl" "ibm_db_nacl" {
  vpc_id = aws_vpc.ibm_vpc.id

  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535
  }

  tags = {
    Name = "ibm_db_nacl"
  }
}
resource "aws_network_acl_association" "ibm_web_nacl_associate"{
  subnet_id = aws_subnet.ibm_web_sn.id
  nacl_id = aws_network_acl.ibm_web_nacl.id
}
resource "aws_network_acl_association" "ibm_db_nacl_associate"{
  subnet_id = aws_subnet.ibm_db_sn.id
  nacl_id = aws_network_acl.ibm_db_nacl.id
}
