
resource "google_compute_network" "my_vpc" {
  name = "my-vpc"
  delete_default_routes_on_create = false
  auto_create_subnetworks = false
  project = var.project_id
  mtu = 1460
}



/*
resource "google_compute_network" "my_internet_gateway" {
  project = var.project_id
  name    = "my-internet-gateway"
}


resource "google_compute_router_nat" "my_internet_gateway_nat" {
  project = var.project_id
  name         = "my-internet-gateway-nat"
  router       = google_compute_router.my_router.name
  region       = var.region
  nat_ip_allocate_option = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name = "projects/${var.project_id}/regions/${var.region}/subnetworks/public-subnet"
    source_ip_ranges_to_nat = [ "ALL_IP_RANGES" ]
    
  }
}

resource "google_compute_route" "default_route_public" {
  project = var.project_id
  name    = "default-route-public"
  network = google_compute_network.my_vpc.name
  dest_range = "0.0.0.0/0"
  next_hop_gateway = "default-internet-gateway"
}
*/

resource "google_compute_subnetwork" "public_subnet" {
  project = var.project_id
  name          = "public-subnet"
  ip_cidr_range = var.public_subnet_cidr
  region        = var.region
  network       = google_compute_network.my_vpc.name
}

resource "google_compute_subnetwork" "private_subnet" {
  project = var.project_id
  name          = "private-subnet"
  ip_cidr_range = var.private_subnet_cidr
  region        = var.region
  network       = google_compute_network.my_vpc.name
}

resource "google_compute_router" "nat_router" {
  project = var.project_id
  region = var.region
  name    = "nat-router"
  network = var.vpc-name
}

resource "google_compute_router_nat" "nat_config" {
  region = var.region
  project = var.project_id
  name             = "nat-config"
  router           = google_compute_router.nat_router.name
  nat_ip_allocate_option = "AUTO_ONLY"

  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}
/*
resource "google_compute_router" "my_router" {
  region = var.region
  project = var.project_id
  name    = "my-router"
  network = google_compute_network.my_vpc.name
}

resource "google_compute_router_nat" "my_nat" {
  project = var.project_id
  name         = "my-nat"
  router       = google_compute_router.my_router.name
  region       = var.region
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  nat_ip_allocate_option = "AUTO_ONLY"

  subnetwork {
    name = "projects/${var.project_id}/regions/${var.region}/subnetworks/private-subnet"
    source_ip_ranges_to_nat = [ "ALL_IP_RANGES" ]
  }
}

*/
output "public_subnet" {
  value = google_compute_subnetwork.public_subnet.id
}

output "private_subnet" {
  value = google_compute_subnetwork.private_subnet.id
}

output "vpc_id" {
  value = google_compute_network.my_vpc.id
}
