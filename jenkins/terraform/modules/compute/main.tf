
resource "google_compute_instance" "jenkins" {
  name         = "jenkins-server"
  machine_type = "e2-medium"
  project = var.project_id
  zone = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = var.vpc-name
    subnetwork = var.public_subnet
    access_config {
      // Ephemeral IP
    }
  }

  tags = ["jenkins-server"]

   metadata_startup_script = <<-EOF
    #!/bin/bash
    # Install Jenkins
    sudo apt update
    sudo apt install openjdk-11-jre -y
    curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
    /usr/share/keyrings/jenkins-keyring.asc > /dev/null
    echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
    https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null
    sudo apt-get update
    sudo apt-get install jenkins -y
  EOF
}


resource "google_compute_instance" "postgress_db" {
  project = var.project_id
  name         = "postgres-db"
  machine_type = var.e2-micro 
  zone = var.zone
  tags = [ "postgres-db" ]
  boot_disk {
    initialize_params {
      image = var.ubuntu
      size  = 20
      type  = "pd-standard"
    }
  }

  network_interface {
    network = var.vpc-name
    subnetwork = var.private_subnet
  }

  metadata_startup_script = <<-EOF
    sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
    sudo apt-get update
    sudo apt-get -y install postgresql
  EOF
}

resource "google_compute_instance" "jumpbox" {
  project = var.project_id
  name         = "jumpbox"
  machine_type = var.e2-micro
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.ubuntu
    }
  }

  service_account {
    email = "897847963527-compute@developer.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }

  network_interface {
    network    = var.vpc-name
    subnetwork = var.public_subnet
    access_config {
      
    }
  }

  tags = ["jumpbox"]
}

/*
resource "google_project_iam_binding" "example_instance_iam_binding" {
  project = var.project_id
  role    = "roles/compute.instanceAdmin"
  
  members = [
    "serviceAccount:897847963527-compute@developer.gserviceaccount.com"
  ]
}

*/