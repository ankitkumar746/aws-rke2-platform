resource "aws_subnet" "g0_subnets" {
  for_each = { for subnet in var.g0_subnets_config : subnet.tags.Name => subnet }
  vpc_id            = aws_vpc.g0_vpc.id      # implicit dependency (vpc is created first)
  cidr_block        = each.value.cidr
  availability_zone = each.value.az
  tags              = merge(each.value.tags, var.subnet_common_tags)
}
