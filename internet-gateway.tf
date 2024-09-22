resource "aws_internet_gateway" "g0_ig" {
  vpc_id = aws_vpc.g0_vpc.id
  tags   = var.g0_internet_gateway_config.tags
}
