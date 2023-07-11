resource "aws_instance" "web" {
  ami           = "ami-03265a0778a880afb"
  instance_type = "t3.small"
  vpc_security_group_ids = [aws_security_group.sample.id]

  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = "centos"
      password = "DevOps321"
      host     = self.public_ip

      inline = [
        "sudo labauto ansible",
        "ansible-pull -i localhost, -U https://github.com/janardhanReddy-B/roboshop-ansible-b.git -e env=dev -e role_name=${var.Name}",
      ]
    }
  }

  tags = {
    Name = var.Name
  }
}

variable "Name" {}

resource "aws_security_group" "sample" {
  name        = var.Name

  ingress {
    description      = "TLS from VPC"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}