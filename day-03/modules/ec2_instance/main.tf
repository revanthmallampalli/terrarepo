provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "day3" {
    ami = var.ami_value
    instance_type = var.instance_type_value 
}
