module "provider" {
  source = "./provider"
}

module "key_pair" {

  source    = "./key_pair"
  key_name  = "cluster_key"
  file_name = "${path.module}/cluster_key.pem"
}

module "vpc" {

  source = "./vpc"
}

module "subnets" {

  source = "./subnets"
  vpc_id = module.vpc.vpc_id
}

module "routes" {

  source          = "./routes"
  vpc_id          = module.vpc.vpc_id
  gateway_id      = module.vpc.internet_gateway_id
  public_subnet_1 = module.subnets.public_subnet_1_id
  public_subnet_2 = module.subnets.public_subnet_2_id
  public_subnet_3 = module.subnets.public_subnet_3_id

}

module "nat_gateways" {

  source                = "./nat_gateways"
  public_subnet_1       = module.subnets.public_subnet_1_id
  public_subnet_2       = module.subnets.public_subnet_2_id
  public_subnet_3       = module.subnets.public_subnet_3_id
  private_route_table_1 = module.routes.private_route_table_1_id
  private_route_table_2 = module.routes.private_route_table_2_id
  private_route_table_3 = module.routes.private_route_table_3_id
}


module "security_groups" {

  source = "./security_groups"
  vpc    = module.vpc.vpc_id
}

module "elastic_load_balancer" {

  source          = "./elastic_load_balancer"
  vpc_id          = module.vpc.vpc_id
  public_subnet_1 = module.subnets.public_subnet_1_id
  public_subnet_2 = module.subnets.public_subnet_2_id
  public_subnet_3 = module.subnets.public_subnet_3_id
  elb_sg          = module.security_groups.elb_sg_id
}

module "ec2-master-subnet1" {

  source        = "./ec2"
  ami_id        = "ami-0866a3c8686eaeeba"
  instance_type = "t2.micro"
  instance_name = "master-subnet1"
  key_pair_name = module.key_pair.key_name
  sg_name       = module.security_groups.master_sg_id
  subnet_id     = module.subnets.public_subnet_1_id
}


module "ec2-worker-subnet1" {

  source        = "./ec2"
  ami_id        = "ami-0866a3c8686eaeeba"
  instance_type = "t2.micro"
  instance_name = "worker-subnet1"
  key_pair_name = module.key_pair.key_name
  sg_name       = module.security_groups.worker_sg_id
  subnet_id     = module.subnets.public_subnet_1_id
}


module "ec2-master-subnet2" {

source        = "./ec2"
  ami_id        = "ami-0866a3c8686eaeeba"
  instance_type = "t2.micro"
  instance_name = "master-subnet2"
  key_pair_name = module.key_pair.key_name
  sg_name       = module.security_groups.master_sg_id
  subnet_id     = module.subnets.public_subnet_2_id
}


module "ec2-worker-subnet2" {

source        = "./ec2"
  ami_id        = "ami-0866a3c8686eaeeba"
  instance_type = "t2.micro"
  instance_name = "worker-subnet2"
  key_pair_name = module.key_pair.key_name
  sg_name       = module.security_groups.worker_sg_id
  subnet_id     = module.subnets.public_subnet_2_id
}


module "ec2-master-subnet3" {

source        = "./ec2"
  ami_id        = "ami-0866a3c8686eaeeba"
  instance_type = "t2.micro"
  instance_name = "master-subnet3"
  key_pair_name = module.key_pair.key_name
  sg_name       = module.security_groups.master_sg_id
  subnet_id     = module.subnets.public_subnet_3_id

}


module "ec2-worker-subnet3" {

source        = "./ec2"
  ami_id        = "ami-0866a3c8686eaeeba"
  instance_type = "t2.micro"
  instance_name = "worker-subnet3"
  key_pair_name = module.key_pair.key_name
  sg_name       = module.security_groups.worker_sg_id
  subnet_id     = module.subnets.public_subnet_3_id

}


module "attach-worker-subnet1-to-elb" {
source   = "./target_group_attachment"
target_group_arn = module.elastic_load_balancer.target_group_arn
worker_node_id = module.ec2-worker-subnet1.instance_id
}

module "attach-worker-subnet2-to-elb" {
source   = "./target_group_attachment"
target_group_arn = module.elastic_load_balancer.target_group_arn
worker_node_id = module.ec2-worker-subnet2.instance_id
}


module "attach-worker-subnet3-to-elb" {
source   = "./target_group_attachment"
target_group_arn = module.elastic_load_balancer.target_group_arn
worker_node_id = module.ec2-worker-subnet3.instance_id
}
