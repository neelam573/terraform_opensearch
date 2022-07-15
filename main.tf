provider "aws" {
  region = "us-east-1"

}
module "vpc_module" {
  source   = "./modules/vpc"
  vpc_name = var.vpc_name
  vpc_cidr = var.vpc_cidr

}
module "subnet_module" {
  source               = "./modules/subnet"
  publicsubnet_name    = var.publicsubnet_name
  public_subnets_cidr  = var.public_subnets_cidr
  private_subnets_cidr = var.private_subnets_cidr
  privatesubnet_name   = var.privatesubnet_name
  vpc_id               = module.vpc_module.vpc_id

}

module "internet_gateway_module" {
  source           = "./modules/internet_gateway"
  vpc_id           = module.vpc_module.vpc_id
  internet_gateway = var.internet_gateway

}

module "nat_gateway_module" {
  source                  = "./modules/nat_gateway"
  opensearch_publicsubnet = module.subnet_module.aws_subnet[0]
  var_depends_on          = "module.internet_gateway_module"
  nat_gateway_name        = var.nat_gateway_name
}

module "route_table_module" {
  source                   = "./modules/route_table"
  route_public_name        = var.route_public_name
  internet_gateway         = module.internet_gateway_module.aws_internet_gateway
  opensearch_publicsubnet  = module.subnet_module.aws_subnet[0]
  route_private_name       = var.route_private_name
  opensearch_privatesubnet = module.subnet_module.aws_subnet[1]
  nat_gateway              = module.nat_gateway_module.nat_gateway.id
  vpc_id                   = module.vpc_module.vpc_id

}

module "security_group_module" {
  source         = "./modules/security_group"
  sg_publicname  = var.sg_publicname
  my_ip          = var.my_ip
  sg_privatename = var.sg_privatename
  vpc_id         = module.vpc_module.vpc_id
  public_ec2_private_ip = module.ec2_module.public_ec2_private_ip
}

module "key_module" {
  source     = "./modules/key"
  key_name = var.key_name
  key_file = var.key_file
}

module "ec2_module" {
  source                   = "./modules/ec2"
  instance_ami             = var.instance_ami
  instance_type            = var.instance_type
  key_name                 = var.key_name
  public_ec2_name           = var.public_ec2_name
  private_ec2_name          = var.private_ec2_name
  public_subnet_id          = module.subnet_module.aws_subnet[0]
  private_subnet_id         = module.subnet_module.aws_subnet[1]
  public_sg_id            = module.security_group_module.public_security_group_id
  private_sg_id           = module.security_group_module.private_security_group_id
}
