######## Creating VPC ########
resource "aws_vpc" "medstick_prodvpc" {
  cidr_block       = var.vpc_subnet_cidr[0].cidr
  instance_tenancy = "default"
  tags             = local.terratag_added_main
}

######## Creating Internet Gateway ########
resource "aws_internet_gateway" "medstick_prodgateway" {
  vpc_id = aws_vpc.medstick_prodvpc.id
  tags   = local.terratag_added_main
}

######## Creating Subnets ########

######## Creating First Subnet ########
resource "aws_subnet" "medstick_prodsubnet" {
  vpc_id                  = aws_vpc.medstick_prodvpc.id
  cidr_block              = var.vpc_subnet_cidr[1].cidr
  map_public_ip_on_launch = true
  availability_zone       = "ap-south-1a"
  tags                    = local.terratag_added_main
}

######## Creating Second Subnet ########
resource "aws_subnet" "medstick_prodsubnet1" {
  vpc_id                  = aws_vpc.medstick_prodvpc.id
  cidr_block              = var.vpc_subnet_cidr[2].cidr
  map_public_ip_on_launch = true
  availability_zone       = "ap-south-1b"
  tags                    = local.terratag_added_main
}

######## Creating Route Table ########
resource "aws_route_table" "medstick_prodroute" {
  vpc_id = aws_vpc.medstick_prodvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.medstick_prodgateway.id
  }
  tags = local.terratag_added_main
}
resource "aws_route_table_association" "medstick_prodrt" {
  subnet_id      = aws_subnet.medstick_prodsubnet.id
  route_table_id = aws_route_table.medstick_prodroute.id
}
resource "aws_route_table_association" "medstick_prodrt2" {
  subnet_id      = aws_subnet.medstick_prodsubnet1.id
  route_table_id = aws_route_table.medstick_prodroute.id
}

locals {
  terratag_added_main = { "Project" = "Medstick", "Project_Manager" = "Vrusha", "Purpose" = "Prod", "created_by" = "priyanka.pradhan@nineleaps.com", "environment_id" = "prod" }
}

