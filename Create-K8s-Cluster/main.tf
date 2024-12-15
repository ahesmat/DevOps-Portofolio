module "provider" {
  source = "./provider"
}

module "key_pair" {

  source = "./key_pair"
}

module "vpc" {

  source = "./vpc"
}

module "subnets" {

  source = "./subnets"
  vpc_id = module.vpc.vpc_id
}

module "routes" {

  source = "./routes"
  vpc_id = module.vpc.vpc_id
  gateway_id = module.vpc.internet_gateway_id
  public_subnet_1=module.subnets.public_subnet_1_id
  public_subnet_2=module.subnets.public_subnet_2_id
  public_subnet_3=module.subnets.public_subnet_3_id

}

module "nat_gateways" {
         
  source = "./nat_gateways"
  public_subnet_1=module.subnets.public_subnet_1_id
  public_subnet_2=module.subnets.public_subnet_2_id
  public_subnet_3=module.subnets.public_subnet_3_id
  private_route_table_1=module.routes.private_route_table_1_id
  private_route_table_2=module.routes.private_route_table_2_id
  private_route_table_3=module.routes.private_route_table_3_id
} 
