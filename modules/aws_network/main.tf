data "aws_availability_zones" "available" {
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.environment}-vpc"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.environment}-igw"
  }
}

#-------------Public Subnets and Routing----------------------------------------
resource "aws_subnet" "public" {
  count                   = var.az_count
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.environment}-public"
  }
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.main.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.environment}-routing-table-public"
  }
}

resource "aws_route_table_association" "public" {
  count          = var.az_count
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

#--------------Private Subnets and Routing-------------------------
resource "aws_subnet" "private" {
  count             = var.az_count
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 8, var.az_count + count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "${var.environment}-private"
  }
}

resource "aws_route" "private" {
  count                  = var.az_count
  route_table_id         = element(aws_route_table.private.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.main.*.id, count.index)
}

resource "aws_route_table" "private" {
  count  = var.az_count
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.environment}-route-private-subnet"
  }
}

resource "aws_route_table_association" "private" {
  count          = var.az_count
  route_table_id = element(aws_route_table.private.*.id, count.index)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
}

#-----NAT Gateways with Elastic IPs--------------------------
resource "aws_eip" "main" {
  count = var.az_count
  vpc   = true
  depends_on = [aws_internet_gateway.main]
  tags = {
    Name = "${var.environment}-eip"
  }
}

resource "aws_nat_gateway" "main" {
  count         = var.az_count
  allocation_id = element(aws_eip.main.*.id, count.index)
  subnet_id     = element(aws_subnet.public.*.id, count.index)
  tags = {
    Name = "${var.environment}-nat-gw"
  }
}