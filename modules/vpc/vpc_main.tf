resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr
}

# Create a public subnet
resource "aws_subnet" "main_vpc_public_subnet" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-west-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "main_vpc_public_subnet"
  }
}

# Create an internet gateway
resource "aws_internet_gateway" "main_vpc_igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "main_vpc_igw"
  }
}

# Create a route table for the public subnet
resource "aws_route_table" "public_subnet_route" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_vpc_igw.id
  }

  route {
    cidr_block = var.vpc_pub_sub_cidr
    gateway_id = "local"
  }

  tags = {
    Name = "public_subnet_route"
  }
}

# Associate the public subnet with the route table
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.main_vpc_public_subnet.id
  route_table_id = aws_route_table.public_subnet_route.id
}

# Create a security group allow ssh for my host only
resource "aws_security_group" "ssh_sg" {
  name        = "ssh-sg"
  description = "Security group to allow SSH access from my host only"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["101.93.3.113/32"] # Replace <YOUR_IP> with your actual IP address
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ssh-sg"
  }
}

