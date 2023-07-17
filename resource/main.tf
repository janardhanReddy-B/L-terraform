module "sample" {
  source = "./ec2"
  Name = "frontend"
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