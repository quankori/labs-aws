// Init VPC
resource "aws_vpc" "prj_vpc_dev" {
  cidr_block           = var.cidr_vpc
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "${var.project_name}-vpc-${var.project_env}"
  }
}

// Init subnet 
resource "aws_subnet" "prj_subnet_public_dev" {
  vpc_id            = aws_vpc.prj_vpc_dev.id
  cidr_block        = var.cidr_public_subnet
  availability_zone = "${var.aws_region}a"
  tags = {
    Name = "${var.project_name}-pubsubnet-${var.project_env}"
  }
}

resource "aws_subnet" "prj_subnet_private_dev" {
  vpc_id            = aws_vpc.prj_vpc_dev.id
  cidr_block        = var.cidr_private_subnet
  availability_zone = "${var.aws_region}a"
  tags = {
    Name = "${var.project_name}-prisubnet-${var.project_env}"
  }
}

// EIP for NAT Gatway
resource "aws_eip" "prj_eip_dev" {
  tags = {
    Name = "${var.project_name}-eip-${var.project_env}"
  }
}

// Init gateway
resource "aws_internet_gateway" "prj_igw_dev" {
  vpc_id = aws_vpc.prj_vpc_dev.id
  tags = {
    Name = "${var.project_name}-igw-${var.project_env}"
  }
}

// Init NAT Gatway
// Comment code because high pricing
# resource "aws_nat_gateway" "prj_nat_dev" {
#   allocation_id = aws_eip.prj_eip_dev.id
#   subnet_id     = aws_subnet.prj_subnet_public_dev.id
#   depends_on    = [aws_eip.prj_eip_dev]
#   tags = {
#     Name = "${var.project_name}-nat-${var.project_env}"
#   }
# }

// Route table
resource "aws_route_table" "prj_rtb_pub_dev" {
  vpc_id = aws_vpc.prj_vpc_dev.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prj_igw_dev.id
  }

  tags = {
    Name = "${var.project_name}-rtbpub-${var.project_env}"
  }
}

resource "aws_route_table" "prj_rtb_pri_dev" {
  vpc_id = aws_vpc.prj_vpc_dev.id

  # route {
  #   cidr_block = "0.0.0.0/0"
  #   gateway_id = aws_nat_gateway.prj_nat_dev.id
  # }

  tags = {
    Name = "${var.project_name}-rtbpri-${var.project_env}"
  }
}

resource "aws_route_table_association" "prj_rtb_asc_pub_dev" {
  subnet_id      = aws_subnet.prj_subnet_public_dev.id
  route_table_id = aws_route_table.prj_rtb_pub_dev.id
}

resource "aws_route_table_association" "prj_rtb_asc_pri_dev" {
  subnet_id      = aws_subnet.prj_subnet_private_dev.id
  route_table_id = aws_route_table.prj_rtb_pri_dev.id
}

// Output
output "prj_vpc_dev_id" {
  value = aws_vpc.prj_vpc_dev.id
}

output "prj_subpub_dev_id" {
  value = aws_subnet.prj_subnet_private_dev.id
}

output "prj_subpri_dev_id" {
  value = aws_subnet.prj_subnet_private_dev.id
}
