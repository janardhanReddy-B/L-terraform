resource "aws_instance" "web" {
  ami           = "ami-03265a0778a880afb"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.sample.id]

  tags = {
    Name = var.Name
  }
}

resource "null_resource" "roboshop" {
  depends_on = [aws_instance.web, aws_route53_record.web]
  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = "centos"
      password = "DevOps321"
      host     = aws_instance.web.public_ip

    }
      inline = [
        "sudo labauto ansible",
        "ansible-pull -i localhost, -U https://github.com/janardhanReddy-B/roboshop-ansible-b.git -e env=dev -e role_name=${var.Name}",
      ]

  }
}

variable "Name" {}

resource "aws_security_group" "sample" {
  name        = var.Name

  ingress {
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
  }

  tags = {
    Name = "sample"
  }
}

resource "aws_route53_record" "web" {
  zone_id = "Z03052753T4U1K1QH805F"
  name    = "${var.Name}-dev"
  type    = "A"
  ttl     = 30
  records = [aws_instance.web.private_ip]
}