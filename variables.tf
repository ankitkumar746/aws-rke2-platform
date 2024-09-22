variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "ap-south-1"  # Mumbai region
}

variable "global_common_tags" {
  type = map(string)
  default = {
    tags = {
      "Project"     = "cloud-platform-001"
      "Environment" = "production"
    }
  }
}

variable "ec2_common_tags" {
  type = map(string)
  default = {
    tags = {
      "ResourceType" = "EC2 Instance"
    }
  }
}

variable "security_group_common_tags" {
  type = map(string)
  default = {
    tags = {
      "ResourceType" = "Security Group"
    }
  }
}

variable "vpc_config" {
  type = object({
    cidr   = string
    tags   = map(string)
  })
  default = {
    cidr = "10.0.0.0/16"
    tags = {
      "Name"         = "g0_vpc"
      "ResourceType" = "VPC"
    }
  }
}

variable "subnet_common_tags" {
  type = map(string)
  default = {
    "ResourceType" = "Subnet"
  }
}

variable "g0_subnets_config" {
  type = list(object({
    cidr = string
    az   = string
    tags = map(string)
  }))
  default = [
    {
      cidr = "10.0.0.0/20"
      az   = "ap-south-1a"
      tags = {
        "Name"         = "g0-pub-1a"
      }
    },
    {
      cidr = "10.0.32.0/20"
      az   = "ap-south-1b"
      tags = {
        "Name"         = "g0-pub-1b"
      }
    },
    {
      cidr = "10.0.64.0/20"
      az   = "ap-south-1c"
      tags = {
        "Name"         = "g0-pub-1c"
      }
    },
    {
      cidr = "10.0.96.0/20"
      az   = "ap-south-1a"
      tags = {
        "Name"         = "g0-prv-1a"
      }
    },
    {
      cidr = "10.0.128.0/20"
      az   = "ap-south-1b"
      tags = {
        "Name"         = "g0-prv-1b"
      }
    },
    {
      cidr = "10.0.160.0/20"
      az   = "ap-south-1c"
      tags = {
        "Name"         = "g0-prv-1c"
      }
    }
  ]
}

variable "g0_internet_gateway_config" {
  type = object({
    tags = map(string) 
  })
  default = {
    tags = {
      "Name"         = "g0-ig"
      "ResourceTupe" = "Internet Gateway" 
    }
  }
}

variable "g0_nat_eip_config" {
  type = object({
    tags = map(string)
  })
  default = {
    tags = {
      "Name" = "g0-pub-1b_nat_eip"
      "ResourceType" = "Internet Gateway"
    }
  }
}


variable "g0_nat_gateway_config" {
  type = object({
    # subnet  = string
    tags    = map(string)
  })
  default = {
    # subnet = "g0-pub-1b"
    tags   = {
      "Name"         = "g0-pub-1b-nat"
      "ResourceType" = "NAT Gateway"
    }
  }
}

variable "private_subnet_route_table_config" {
  type = object({
    tags = map(string)
  })
  default = {
    tags = {
      "Name" = "g0-prv-nat-rt"
      "ResourceType" = "Route Table"
    }
  }
}

variable "public_subnet_route_table_config" {
  type = object({
    tags = map(string)
  })
  default = {
    tags = {
      "Name" = "g0-pub-nat-rt"
      "ResourceType" = "Route Table"
    }
  }
}