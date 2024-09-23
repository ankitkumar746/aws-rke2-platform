provider "aws" {
  region = var.aws_region
  default_tags {
    tags = var.global_common_tags.tags
  }
}
