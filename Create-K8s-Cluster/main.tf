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
  private_subnet_1 = module.subnets.private_subnet_1_id
private_subnet_2 = module.subnets.private_subnet_2_id
private_subnet_3 = module.subnets.private_subnet_3_id

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

module "elastic_load_balancer_worker" {

  source          = "./elastic_load_balancer"
  vpc_id          = module.vpc.vpc_id
  subnet_1 = module.subnets.public_subnet_1_id
  subnet_2 = module.subnets.public_subnet_2_id
  subnet_3 = module.subnets.public_subnet_3_id
  elb_sg          = module.security_groups.elb_sg_worker_id
  lb_name         = "WorkersLoadBalancer"
  tg_name         = "workersTargetGroup"
  protocol        = "HTTPS"
  port            = 443
  path            = "/"
}


module "elastic_load_balancer_master" {

  source          = "./elastic_load_balancer"
  vpc_id          = module.vpc.vpc_id
  subnet_1 = module.subnets.public_subnet_1_id
  subnet_2 = module.subnets.public_subnet_2_id
  subnet_3 = module.subnets.public_subnet_3_id
  elb_sg          = module.security_groups.elb_sg_master_id
  lb_name         = "MastersLoadBalancer"
  tg_name         = "MastersTargetGroup"
  protocol        = "HTTPS"
  port            = 6443
  path            = "/healthz"
}

module "ec2-jumpbox" {

  source        = "./ec2"
  ami_id        = "ami-0866a3c8686eaeeba"
  instance_type = "t2.micro"
  instance_name = "JumpBox"
  key_pair_name = module.key_pair.key_name
  sg_name       = module.security_groups.jump_sg_id
  subnet_id     = module.subnets.public_subnet_1_id
}


module "ec2-master-subnet1" {

  source        = "./ec2"
  ami_id        = "ami-0866a3c8686eaeeba"
  instance_type = "t3.medium"
  instance_name = "master-subnet1"
  key_pair_name = module.key_pair.key_name
  sg_name       = module.security_groups.master_sg_id
  subnet_id     = module.subnets.private_subnet_1_id
}


module "ec2-worker-subnet1" {

  source        = "./ec2"
  ami_id        = "ami-0866a3c8686eaeeba"
  instance_type = "t3.medium"
  instance_name = "worker-subnet1"
  key_pair_name = module.key_pair.key_name
  sg_name       = module.security_groups.worker_sg_id
  subnet_id     = module.subnets.private_subnet_1_id
}


module "ec2-master-subnet2" {

  source        = "./ec2"
  ami_id        = "ami-0866a3c8686eaeeba"
  instance_type = "t3.medium"
  instance_name = "master-subnet2"
  key_pair_name = module.key_pair.key_name
  sg_name       = module.security_groups.master_sg_id
  subnet_id     = module.subnets.private_subnet_2_id
}


module "ec2-worker-subnet2" {

  source        = "./ec2"
  ami_id        = "ami-0866a3c8686eaeeba"
  instance_type = "t3.medium"
  instance_name = "worker-subnet2"
  key_pair_name = module.key_pair.key_name
  sg_name       = module.security_groups.worker_sg_id
  subnet_id     = module.subnets.private_subnet_2_id
}


module "ec2-master-subnet3" {

  source        = "./ec2"
  ami_id        = "ami-0866a3c8686eaeeba"
  instance_type = "t3.medium"
  instance_name = "master-subnet3"
  key_pair_name = module.key_pair.key_name
  sg_name       = module.security_groups.master_sg_id
  subnet_id     = module.subnets.private_subnet_3_id

}


module "ec2-worker-subnet3" {

  source        = "./ec2"
  ami_id        = "ami-0866a3c8686eaeeba"
  instance_type = "t3.medium"
  instance_name = "worker-subnet3"
  key_pair_name = module.key_pair.key_name
  sg_name       = module.security_groups.worker_sg_id
  subnet_id     = module.subnets.private_subnet_3_id

}

module "attach-master-subnet1-to-elb" {
  source           = "./target_group_attachment"
  target_group_arn = module.elastic_load_balancer_master.target_group_arn
  instance_id   = module.ec2-master-subnet1.instance_id
  port             = 6443
}

module "attach-master-subnet2-to-elb" {
  source           = "./target_group_attachment"
  target_group_arn = module.elastic_load_balancer_master.target_group_arn
  instance_id   = module.ec2-master-subnet2.instance_id
  port             = 6443
}


module "attach-master-subnet3-to-elb" {
  source           = "./target_group_attachment"
  target_group_arn = module.elastic_load_balancer_master.target_group_arn
  instance_id   = module.ec2-master-subnet3.instance_id
  port             = 6443
}

module "attach-worker-subnet1-to-elb" {
  source           = "./target_group_attachment"
  target_group_arn = module.elastic_load_balancer_worker.target_group_arn
  instance_id   = module.ec2-worker-subnet1.instance_id
  port             = 80
}

module "attach-worker-subnet2-to-elb" {
  source           = "./target_group_attachment"
  target_group_arn = module.elastic_load_balancer_worker.target_group_arn
  instance_id   = module.ec2-worker-subnet2.instance_id
  port             = 80
}


module "attach-worker-subnet3-to-elb" {
  source           = "./target_group_attachment"
  target_group_arn = module.elastic_load_balancer_worker.target_group_arn
  instance_id   = module.ec2-worker-subnet3.instance_id
  port             = 80
}

module "attach-master-subnet1-to-ebs" {
 source           = "./ebs_volume"
 availability_zone = module.subnets.az1
 volume_name = "volume-master-subnet1"
 instance_id = module.ec2-master-subnet1.instance_id
}

module "attach-master-subnet2-to-ebs" {
 source           = "./ebs_volume"
 availability_zone = module.subnets.az2
 volume_name = "volume-master-subnet2"
 instance_id = module.ec2-master-subnet2.instance_id
}

module "attach-master-subnet3-to-ebs" {
 source           = "./ebs_volume"
 availability_zone = module.subnets.az3
 volume_name = "volume-master-subnet3"
 instance_id = module.ec2-master-subnet3.instance_id
}

module "attach-worker-subnet1-to-ebs" {
 source           = "./ebs_volume"
 availability_zone = module.subnets.az1
 volume_name = "volume-worker-subnet1"
 instance_id = module.ec2-worker-subnet1.instance_id
}

module "attach-worker-subnet2-to-ebs" {
 source           = "./ebs_volume"
 availability_zone = module.subnets.az2
 volume_name = "volume-worker-subnet2"
 instance_id = module.ec2-worker-subnet2.instance_id
}

module "attach-worker-subnet3-to-ebs" {
 source           = "./ebs_volume"
 availability_zone = module.subnets.az3
 volume_name = "volume-worker-subnet3"
 instance_id = module.ec2-worker-subnet3.instance_id
}

module "dns-zone" {
 source          = "./dns_zone"
 domain_name     = "mycluster.life"
}

module "dns-record-worker-lb" {
 source         = "./dns_records"
 zone_id        = module.dns-zone.zone_id
 name           = "public.${module.dns-zone.domain_name}"
 lb_dns_name    = module.elastic_load_balancer_worker.lb_dns_name
 lb_zone_id     = module.elastic_load_balancer_worker.lb_zone_id
}

module "dns-record-master-lb" {
 source         = "./dns_records"
 zone_id        = module.dns-zone.zone_id
 name           = "private.${module.dns-zone.domain_name}"
 lb_dns_name    = module.elastic_load_balancer_master.lb_dns_name
 lb_zone_id     = module.elastic_load_balancer_master.lb_zone_id
}

module "cert-generation-and-validation" {
 source         = "./cert_generation_and_validation"
 domain_name    = module.dns-zone.domain_name
 zone_id        = module.dns-zone.zone_id
}

module "worker-alb-listener" {
source          = "./alb_listener"
lb_arn          = module.elastic_load_balancer_worker.lb_arn
port            = 443
cert_arn        = module.cert-generation-and-validation.certificate_arn
tg_arn          = module.elastic_load_balancer_worker.target_group_arn
}

module "master-alb-listener" {
source          = "./alb_listener"
lb_arn          = module.elastic_load_balancer_master.lb_arn
port            = 6443
cert_arn        = module.cert-generation-and-validation.certificate_arn
tg_arn          = module.elastic_load_balancer_master.target_group_arn
}
