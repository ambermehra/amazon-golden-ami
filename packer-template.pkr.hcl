packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "aws_region" {
  type    = string
  default = "us-west-2"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

source "amazon-ebs" "custom_ami" {
  region = var.aws_region
  source_ami_filter {
    filters = {
      name                = "amzn2-ami-hvm-*-x86_64-gp2"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    owners      = ["amazon"]
    most_recent = true
  }
  instance_type = var.instance_type
  ssh_username  = "ec2-user"
  ami_name      = "custom-amazon-linux-2-{{timestamp}}"
  tags = {
    Name        = "Custom-AMI"
    Environment = "Production"
  }
}

build {
  sources = ["source.amazon-ebs.custom_ami"]

  provisioner "chef-solo" {
    cookbook_paths = ["./cookbooks"]
    run_list       = [
      "recipe[aws_ssm_plugin::default]",
      "recipe[cloudwatch_agent::default]",
      "recipe[postgres_db::default]"
    ]
  }
}
