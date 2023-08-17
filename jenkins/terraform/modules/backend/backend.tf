

provider "google" {
  project     = "your-gcp-project-id"
  region      = "us-central1"  # Change to your desired region
}

resource "google_compute_firewall" "backend_firewall" {
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
    access_config {
      
    }
  }

  tags = ["backend"]
}
