
provider "google" {
  project     = var.project_id
  region      = "us-central1"  # Change to your desired region
  credentials = file("credentials.json")
  zone = var.zone
}

resource "google_compute_firewall" "backend_firewall" {
  project = var.project_id
  name    = "backend-firewall"
  network = "my-vpc"

  allow {
    protocol = "tcp"
    ports    = ["22", "3030", "9100"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["backend"]
}

resource "google_compute_instance" "backend_server" {
  project = var.project_id
  name         = "backend-server"
  machine_type = "e2-micro"  # Change to your desired machine type
  zone         = "us-central1-c"  # Change to your desired zone

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  network_interface {
    network = "my-vpc"
    subnetwork = "private-subnet"
    access_config {
      
    }
  }

  tags = ["backend"]
}
