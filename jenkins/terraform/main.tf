module "network" {
  source = "./modules/network"
}
module "compute" {
  source = "./modules/compute" 

  public_subnet =  module.network.public_subnet
  private_subnet = module.network.private_subnet
}

module "security" {
  source = "./modules/security"
}

module "backend" {
  source = "./modules/backend"

  private_subnet = module.network.private_subnet
  public_subnet = module.network.public_subnet
}