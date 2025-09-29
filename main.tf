# VPC 
resource "aws_vpc" "main" { 
  cidr_block = var.vpc_cidr 
  tags = { 
    Name = "DerickVPC" 
  } 
} 
 
# Subnet 
resource "aws_subnet" "public" { 
  vpc_id                  = aws_vpc.main.id 
  cidr_block              = var.subnet_cidr 
  map_public_ip_on_launch = true 
  availability_zone       = "ap-northeast-2a" 
  tags = { 
    Name = "PublicSubnet" 
  } 
} 
 
# Internet Gateway 
resource "aws_internet_gateway" "gw" { 
  vpc_id = aws_vpc.main.id 
} 
 
# Route Table 
resource "aws_route_table" "public" { 
  vpc_id = aws_vpc.main.id 
} 
 
resource "aws_route" "internet_access" { 
  route_table_id         = aws_route_table.public.id 
  destination_cidr_block = "0.0.0.0/0" 
  gateway_id             = aws_internet_gateway.gw.id 
} 
 
resource "aws_route_table_association" "public_assoc" { 
  subnet_id      = aws_subnet.public.id 
  route_table_id = aws_route_table.public.id 
} 
 
# Security Group 
resource "aws_security_group" "allow_ssh" { 
  vpc_id = aws_vpc.main.id 
 
  ingress { 
    description = "SSH" 
    from_port   = 22 
    to_port     = 22 
    protocol    = "tcp" 
    cidr_blocks = ["0.0.0.0/0"] 
  } 
 
  egress { 
from_port   = 0 
to_port     = 0 
protocol    = "-1" 
cidr_blocks = ["0.0.0.0/0"] 
} 
} 
# ------------------------- 
# Generate SSH Key Pair 
resource "tls_private_key" "my_key" { 
algorithm = "RSA" 
rsa_bits  = 4096 
} 
resource "aws_key_pair" "my_key" { 
key_name   = var.key_name                  # Using variable 
public_key = tls_private_key.my_key.public_key_openssh 
} 
# EC2 Instance 
resource "aws_instance" "my_ec2" { 
ami           = "ami-077ad873396d76f6a" # Amazon Linux 2 (check for your region) 
instance_type = var.instance_type 
subnet_id     = aws_subnet.public.id 
vpc_security_group_ids = [aws_security_group.allow_ssh.id] 
key_name      = aws_key_pair.my_key.key_name  # Use Terraform-created key 
tags = { 
Name = "MyEC2" 
} 
} 