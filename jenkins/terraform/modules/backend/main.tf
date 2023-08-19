
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

    metadata = {
    ssh-keys = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDo2XHcJzsXtQzU+EWdoQBa1c7IR5afSBXv7AZecX4HyfRvviub7wm+gR4J14dCj+htxUTTkmgJIa+18cC0JA7ib0sHKrHkNKLkH1onSELjyjbXYO3hzz6Rky9Xc0FqmrGlF1fhdRUe6or6w4idClvgTZReyO1RigqqEjjwvILI2IpgSIR206QyOH6k0KvEinK7R9QfOXaQ3/Om4G1u/kMzxxE/mt5/t3Vv4A9RoVlbg353F2z05s18zXR2oOb/KC6Rjn3NR+vj4komXWf0kl8pSMCFlhDt+A/VM0C+Nwv2Plxq5PpXm1EF8FPDmteUbpKRs7lGSNAzPQYbypQCl4Ib asirabdelhady4@jenkins-server"
  }

  tags = ["backend"]
}
