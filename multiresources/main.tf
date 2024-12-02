provider "aws" {
  region = "us-east-1"
  alias  = "us-east-1"
}

provider "aws" {
  region = "us-east-2"
  alias  = "us-east-2"
}

provider "aws" {
  region = "us-west-1"
  alias  = "us-west-1"
}

locals {
  configs = {
    "us-east-1" = { ami = "ami-038bba9a164eb3dc1", instance_type = "t2.medium", key_name = "virgina", name = "Instance in us-east-1" },
    "us-east-2" = { ami = "ami-0c80e2b6ccb9ad6d1", instance_type = "t2.micro", key_name = "keethu", name = "Instance in us-east-2" },
    "us-west-1" = { ami = "ami-0453ec754f44f9a4a", instance_type = "t2.small", key_name = "pranu", name = "Instance in us-west-1" }
  }
}

resource "aws_instance" "my_instance" {
  for_each       = { for idx, cfg in local.configs : cfg.name => cfg }
  provider       = aws.${each.value.provider}  # Correct provider alias reference
  ami            = each.value.ami
  instance_type  = each.value.instance_type
  key_name       = each.value.key_name
  tags = {
    Name = each.value.name
  }
}