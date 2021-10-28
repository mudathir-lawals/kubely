# #--------------------------------------------------------------
# # Vpc module
# #--------------------------------------------------------------
# data "aws_region" "current" {}

# # locals {
# #   azs               = length(var.availability_zones) > 0 ? var.availability_zones : data.aws_availability_zones.main.names
# #   nat_gateway_count = var.create_nat_gateways ? min(length(local.azs), length(var.public_subnet_cidrs), length(var.private_subnet_cidrs)) : 0
# # }

# resource "aws_vpc" "vpc" {
#     cidr_block              =  var.vpc_cidr
#     enable_dns_support      = true
#     enable_dns_hostnames    = var.enable_dns_hostnames
#     assign_generated_ipv6_cidr_block =  var.assign_generated_ipv6_cidr_block

#     tags = {
#     Name                    = "${var.name}-vpc"
#     Environment             = var.environment
#   }
#   lifecycle {
#     create_before_destroy   = true
#   }
# }

# #--------------------------------------------------------------
# # Subnets module
# #--------------------------------------------------------------

# #--------------------------------------------------------------
# # Public Subnet Module
# #--------------------------------------------------------------

# resource "aws_internet_gateway" "public" {
#   count                     = length(var.public_subnet_cidrs) > 0 ? 1 : 0
#   depends_on                = [aws_vpc.vpc]
#   vpc_id                    = aws_vpc.vpc.id

#   tags                      = {
#     Name                    = "${var.name}-public-igw"
#     Environment             = var.environment
#   }
# }

# resource "aws_eip" "nat_eip" {
#   vpc                      = true
#   depends_on               = [aws_internet_gateway.public]
# }

# resource "aws_egress_only_internet_gateway" "outbound" {
#   depends_on               = [aws_vpc.vpc]
#   vpc_id                   = aws_vpc.vpc.id
# }


# /* Routing table for public subnet */
# resource "aws_route_table" "public" {
#   depends_on                = [aws_vpc.vpc]
#   vpc_id                    = aws_vpc.vpc.id
#   tags = {
#     Name                    = "${var.name}-public-route-table"
#     Environment             = var.environment
#   }
# }

# /* Route for public subnet */

# resource "aws_route" "public_internet_gateway" {
#   depends_on                = [
#     aws_internet_gateway.public,
#     aws_route_table.public,
#   ]
#   route_table_id            = aws_route_table.public.id
#   destination_cidr_block    = "0.0.0.0/0"
#   gateway_id                = aws_internet_gateway.public.id
# }

# /* Public subnet */
# resource "aws_subnet" "public_subnet" {
#   vpc_id                    = aws_vpc.vpc.id
#   count                     = length(var.public_subnets_cidrs)
#   cidr_block                = element(var.public_subnets_cidrs,   count.index)
#   availability_zone         = element(var.availability_zones,   count.index)
#   map_public_ip_on_launch   = var.map_public_ip_on_launch

#   tags = {
#     Name                    = "${var.name}-${element(var.availability_zones, count.index)}-public-subnet"
#     Environment             = "${var.environment}"
#   }
# }

# /* Route table associations */
# resource "aws_route_table_association" "public" {
#   count          = length(var.public_subnets_cidrs)
#   subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
#   route_table_id = aws_route_table.public.id
# }

# /* NAT */
# resource "aws_nat_gateway" "nat" {
#   allocation_id = aws_eip.nat_eip.id
#   subnet_id     = element(aws_subnet.public_subnet.*.id, 0)
#   depends_on    = [aws_internet_gateway.ig]
#   tags = {
#     Name        = "${var.name}-nat"
#     Environment = var.environment
#   }
# }

# #--------------------------------------------------------------
# # Public Subnet Module
# #--------------------------------------------------------------

# resource "aws_subnet" "private_subnet" {
#   vpc_id                  = aws_vpc.vpc.id
#   count                   = length(var.private_subnets_cidrs)
#   cidr_block              = element(var.private_subnets_cidrs, count.index)
#   availability_zone       = element(var.availability_zones,   count.index)
#   map_public_ip_on_launch = false
#   tags = {
#     Name        = "${var.name}-${element(var.availability_zones, count.index)}-private-subnet"
#     Environment = var.environment
#   }
# }
# /* Routing table for private subnet */
# resource "aws_route_table" "private" {
#   vpc_id = "${aws_vpc.vpc.id}"
#   tags = {
#     Name        = "${var.name}-private-route-table"
#     Environment = var.environment
#   }
# }

# resource "aws_route" "private_nat_gateway" {
#   route_table_id         = aws_route_table.private.id
#   destination_cidr_block = "0.0.0.0/0"
#   nat_gateway_id         = aws_nat_gateway.nat.id
# }

# resource "aws_route_table_association" "private" {
#   count          = length(var.private_subnets_cidrs)
#   subnet_id      = element(aws_subnet.private_subnet.*.id, count.index)
#   route_table_id = aws_route_table.private.id
# }
# /*==== VPC's Default Security Group ======*/
# resource "aws_security_group" "default" {
#   name        = "${var.name}-default-sg"
#   description = "Default security group to allow inbound/outbound from the VPC"
#   vpc_id      = "${aws_vpc.vpc.id}"
#   depends_on  = [aws_vpc.vpc]
#   ingress {
#     from_port = "0"
#     to_port   = "0"
#     protocol  = "-1"
#     self      = true
#   }
  
#   egress {
#     from_port = "0"
#     to_port   = "0"
#     protocol  = "-1"
#     self      = "true"
#   }
#   tags = {
#     name        = "${var.name}-"
#     Environment = "${var.environment}"
#   }
# }