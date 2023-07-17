module "sample" {
  for_each = var.instances
  source = "./ec2"
  Name = each.key
  env = var.env
}

variable "instances" {
  default = {

    frontend = {}
    mongodb = {}
    catalogue ={}
    user = {}
    cart = {}
    redis = {}
    mysql = {}
    payment = {}
    shipping = {}
    rabbitmq = {}

  }
}

variable "env" {
  default = "dev"
}