resource "google_compute_firewall" "allow_ssh" {
  project = var.project_id
  name    = "allow-ssh"
  network = var.vpc-name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  direction = "INGRESS"
  target_tags = ["jenkins-server", "jumpbox"]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow_http" {
  project = var.project_id
  name    = "allow-http"
  network = var.vpc-name
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }
  direction = "INGRESS"
  target_tags = ["jenkins-server"]
  source_ranges = ["0.0.0.0/0"]  
}

/*
resource "google_compute_firewall" "my_vpc_firewall" {
  project = var.project_id
  name    = "my-vpc-firewall"
  network = var.vpc-name
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["8080", "80"]
  }
  direction = "INGRESS"
  source_ranges = ["10.0.1.0/24"]  
}
*/

resource "google_compute_firewall" "egress_all" {
  project        = var.project_id
  name           = "egress-all"
  network        = var.vpc-name
  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
    
  }
  direction      = "EGRESS"
  source_ranges  = ["0.0.0.0/0"]
}


resource "google_compute_firewall" "allow_http_postgress" {
  project = var.project_id
  name    = "allow-http-postgres"
  network = var.vpc-name
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["5432"]
  }
  direction = "INGRESS"
  target_tags = ["postgres-db"]
  source_ranges = ["0.0.0.0/0"]  
}

resource "google_compute_firewall" "allow_ssh_postgres" {
  project = var.project_id
  name = "allow-ssh-postgres"
  network = var.vpc-name
  allow {
    protocol = "tcp"
    ports = ["22"]
  }
  direction = "INGRESS"
  target_tags = ["postgres-db"]
  source_tags = ["jumpbox"]
}

resource "google_compute_firewall" "allow_http_jenkins" {
  project = var.project_id
  name    = "allow-http-jenkins"
  network = var.vpc-name
  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }
  direction = "INGRESS"
  target_tags = ["jenkins-server"]
  source_ranges = ["0.0.0.0/0"]  
}

resource "google_compute_firewall" "allow_egress_jenkis" {
  project        = var.project_id
  name           = "allow-egress-jenkis"
  network        = var.vpc-name
  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
    
  }
  direction      = "EGRESS"
  target_tags = ["jenkins-server"]
  source_ranges  = ["0.0.0.0/0"]
}