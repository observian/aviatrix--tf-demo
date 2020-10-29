
resource "aws_vpc" "ob-eks-demo" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "${var.application}-${var.env}-vpc"
  }
}



### AZ 1
resource "aws_subnet" "ob-eks-demo-public-alpha" {
  vpc_id            = aws_vpc.ob-eks-demo.id
  cidr_block        = var.public_alpha_cidr
  availability_zone = lookup(var.zones, "${var.aws_region}-alpha")

  tags = {
    Name        = "${var.application}-${var.env}-public-alpha",
    Environment = var.env
  }
}

# resource "aws_subnet" "ob-eks-demo-private-alpha" {
#   vpc_id            = aws_vpc.ob-eks-demo.id
#   cidr_block        = var.private_alpha_cidr
#   availability_zone = lookup(var.zones, "${var.aws_region}-alpha")

#   tags = {
#     Name = "${var.application}-${var.env}-private-alpha"
#   }
# }

### AZ 2
resource "aws_subnet" "ob-eks-demo-public-bravo" {
  vpc_id            = aws_vpc.ob-eks-demo.id
  cidr_block        = var.public_bravo_cidr
  availability_zone = lookup(var.zones, "${var.aws_region}-bravo")

  tags = {
    Name = "${var.application}-${var.env}-public-bravo",
  }
}

# resource "aws_subnet" "ob-eks-demo-private-bravo" {
#   vpc_id            = aws_vpc.ob-eks-demo.id
#   cidr_block        = var.private_bravo_cidr
#   availability_zone = lookup(var.zones, "${var.aws_region}-bravo")

#   tags = {
#     Name = "${var.application}-${var.env}-private-bravo"
#   }
# }

resource "aws_internet_gateway" "ob-eks-demo-igw" {
  vpc_id = aws_vpc.ob-eks-demo.id
  tags = {
    Name = "${var.application}-${var.env}-igw"
  }
}
# resource "aws_eip" "elastic-ip-alpha" {
#   vpc = true
# }

# resource "aws_eip" "elastic-ip-bravo" {
#   vpc = true
# }

# resource "aws_nat_gateway" "ob-eks-demo-alpha-nat" {

#   subnet_id     = aws_subnet.ob-eks-demo-public-alpha.id
#   allocation_id = aws_eip.elastic-ip-alpha.id
#   depends_on    = [aws_internet_gateway.ob-eks-demo-igw]
#   tags = {
#     Name = "${var.application}-${var.env}-alpha-nat"
#   }
# }

# resource "aws_nat_gateway" "ob-eks-demo-bravo-nat" {

#   subnet_id     = aws_subnet.ob-eks-demo-public-bravo.id
#   allocation_id = aws_eip.elastic-ip-bravo.id
#   depends_on    = [aws_internet_gateway.ob-eks-demo-igw]
#   tags = {
#     Name = "${var.application}-${var.env}-bravo-nat"
#   }
# }

## Route Tables ##
# resource "aws_route_table" "ob-eks-demo-rt-private-alpha" {
#   vpc_id = aws_vpc.ob-eks-demo.id
#   route {
#     cidr_block     = "0.0.0.0/0"
#     nat_gateway_id = aws_nat_gateway.ob-eks-demo-alpha-nat.id
#   }

# }

# resource "aws_route_table_association" "ob-eks-demo-rta-private-alpha" {
#   subnet_id      = aws_subnet.ob-eks-demo-private-alpha.id
#   route_table_id = aws_route_table.ob-eks-demo-rt-private-alpha.id
# }

# resource "aws_route_table" "ob-eks-demo-rt-private-bravo" {
#   vpc_id = aws_vpc.ob-eks-demo.id
#   route {
#     cidr_block     = "0.0.0.0/0"
#     nat_gateway_id = aws_nat_gateway.ob-eks-demo-bravo-nat.id
#   }

# }

# resource "aws_route_table_association" "ob-eks-demo-rta-private-bravo" {
#   subnet_id      = aws_subnet.ob-eks-demo-private-bravo.id
#   route_table_id = aws_route_table.ob-eks-demo-rt-private-bravo.id
# }

resource "aws_route_table" "ob-eks-demo-rt-public-alpha" {
  vpc_id = aws_vpc.ob-eks-demo.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ob-eks-demo-igw.id
  }
}

resource "aws_route_table_association" "ob-eks-demo-rta-public-alpha" {
  subnet_id      = aws_subnet.ob-eks-demo-public-alpha.id
  route_table_id = aws_route_table.ob-eks-demo-rt-public-alpha.id
}

resource "aws_route_table" "ob-eks-demo-rt-public-bravo" {
  vpc_id = aws_vpc.ob-eks-demo.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ob-eks-demo-igw.id
  }
}

resource "aws_route_table_association" "ob-eks-demo-rta-public-bravo" {
  subnet_id      = aws_subnet.ob-eks-demo-public-bravo.id
  route_table_id = aws_route_table.ob-eks-demo-rt-public-bravo.id
}
