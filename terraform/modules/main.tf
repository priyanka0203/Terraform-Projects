module "vpc" {
  source = "./vpc"
}
output "vpc_module" {
  value = module.vpc
}
module "loadbalancer" {
  source  = "./loadbalancer"
  subnets = module.vpc.subnetids
  vpc_id  = module.vpc.vpcid
}
output "lb_module" {
  value = module.loadbalancer
}
module "autoscalinggroup" {
  source   = "./autoscalinggroup"
  secgrpid = module.loadbalancer.secgrpid
  lbid     = module.loadbalancer.lbid
  subnetid = module.vpc.subnetids
}
module "ecr" {
  source = "./ecr"
}
module "rds" {
  source = "./rds"
}
