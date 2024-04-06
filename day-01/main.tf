provider "aws" {
  region = "us-west-2"  # Specify your desired AWS region
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"  # Specify the AMI ID of the instance
  instance_type = "t2.micro"                # Specify the instance type

  tags = {
    Name = "day-01"
  }
}
