provider "aws" {
  region = "us-east-1"
}

variable "cidr" {
  default = "10.0.0.0/16"
}

resource "aws_key_pair" "kp" {
  key_name = "terraform-demo-revanth"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_vpc" "myvpc" {
  cidr_block = var.cidr
}

resource "aws_subnet" "mysubnet" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = "10.0.0.0/24"
  map_public_ip_on_launch = true

}

resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.myvpc.id
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }
}

resource "aws_route_table_association" "rta" {
  subnet_id = aws_subnet.mysubnet.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_security_group" "sg" {
    name = "web"
    vpc_id = aws_vpc.myvpc.id

    ingress {
        description = "HTTP from vpc"
        from_port = "80"
        to_port = "80"
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "SSH"
        from_port = "22"
        to_port = "22"
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    egress {
        description = "outbound"
        from_port = "0"
        to_port = "0"
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    tags ={
        name="web-sg"
    }
  
}

resource "aws_instance" "server" {
    ami = "ami-053b0d53c279acc90"
    instance_type = "t2.micro"
    key_name = aws_key_pair.kp.key_name
    subnet_id = aws_subnet.mysubnet.id
    vpc_security_group_ids = [ aws_security_group.sg.id ]

    tags = {
      name="revanth"
    }

    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = file("~/.ssh/id_rsa")
      host = self.public_ip
    }

      provisioner "file" {
    source      = "app.py"  # Replace with the path to your local file
    destination = "/home/ubuntu/app.py"  # Replace with the path on the remote instance
  }

 provisioner "remote-exec" {
  inline = [
    "echo 'Hello from the remote instance'",
    "sudo apt update -y",  # Update package lists (for Ubuntu)
    "sudo apt-get install -y python3-pip",  # Install Python 3 pip
    "pip3 install --user flask",  # Install Flask locally
    "cd /home/ubuntu",
    "nohup python3 app.py > /dev/null 2>&1 &",  # Start Flask app in the background
  ]
}

}
