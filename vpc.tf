resource "aws_vpc" "g0_vpc" {
  cidr_block = var.vpc_config.cidr
  tags       = var.vpc_config.tags
}
