resource "aws_eip" "g0_nat_eip" {
    tags = var.g0_nat_eip_config.tags
}