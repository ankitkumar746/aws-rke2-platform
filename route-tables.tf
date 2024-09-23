locals {
  private_subnets = { for subnet in var.g0_subnets_config : subnet.tags.Name => subnet if startswith(subnet.tags.Name, "g0-prv") }
  public_subnets  = { for subnet in var.g0_subnets_config : subnet.tags.Name => subnet if startswith(subnet.tags.Name, "g0-pub") }
}

resource "aws_route_table" "g0_prv_nat_rt" {
  vpc_id = aws_vpc.g0_vpc.id
  tags   = var.private_subnet_route_table_config.tags
}

resource "aws_route" "g0_prv_nat_rt_default_route" {
  route_table_id         = aws_route_table.g0_prv_nat_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.g0_nat.id
}

resource "aws_route_table_association" "g0_prv_rt_assoc" {
  for_each       = { for subnet_name, subnet in local.private_subnets : subnet_name => subnet }
  subnet_id      = aws_subnet.g0_subnets[each.key].id
  route_table_id = aws_route_table.g0_prv_nat_rt.id
}

# Route table for public subnets (using Internet Gateway)
resource "aws_route_table" "g0_pub_ig_rt" {
  vpc_id = aws_vpc.g0_vpc.id
  tags = var.public_subnet_route_table_config.tags
}

# Route for public subnets to route all traffic to the Internet Gateway
resource "aws_route" "g0_pub_ig_rt_default_route" {
  route_table_id         = aws_route_table.g0_pub_ig_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.g0_ig.id
}

# Association of the public subnets to the public route table
resource "aws_route_table_association" "g0_pub_rt_assoc" {
  for_each = { for subnet_name, subnet in local.public_subnets : subnet_name => subnet }
  subnet_id      = aws_subnet.g0_subnets[each.key].id
  route_table_id = aws_route_table.g0_pub_ig_rt.id
}
