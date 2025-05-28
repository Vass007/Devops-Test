resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "test-vpc"
  }
}
    resource "aws_subnet" "public_subnet_1" {
        vpc_id = aws_vpc.main.id
        cidr_block = "10.0.1.0/24"
        availability_zone = "ap-south-1a"
        tags = {
            Name = "public_subnet_1"
        }
    }
    resource "aws_subnet" "private_subnet_1" {
        vpc_id = aws_vpc.main.id
        cidr_block = "10.0.2.0/24"
        availability_zone = "ap-south-1a"
        tags = {
            Name = "private_subnet_1"
        }
    }

        resource "aws_route_table" "public_route_table" {
        vpc_id = aws_vpc.main.id
        tags = {
            Name = "public_route_table"
        }
    }
    
    resource "aws_route" "public_route" {
        route_table_id = aws_route_table.public_route_table.id
        destination_cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.internet_gateway.id
    }
    resource "aws_route_table_association" "public_subnet_association" {
  subnet_id     = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route_table.id
}
        resource "aws_internet_gateway" "internet_gateway" {
        vpc_id = aws_vpc.main.id
        tags = {
            Name = "test_internet_gateway"
        }
    }