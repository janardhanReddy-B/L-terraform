module "sample" {
  for_each = var.instances
  source = "./ec2"
  Name = each.key
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