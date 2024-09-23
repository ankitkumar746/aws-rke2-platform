resource "aws_nat_gateway" "g0_nat" {
  allocation_id = aws_eip.g0_nat_eip.id
  subnet_id     = aws_subnet.g0_subnets["g0-pub-1b"].id
  tags          = var.g0_nat_gateway_config.tags
}
