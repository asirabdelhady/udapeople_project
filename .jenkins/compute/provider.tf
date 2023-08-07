provider "google" {
  alias = "vpc"
  credentials = var.project_credentials_file
  project     = var.project_id
  region      = var.region
  zone = var.zone
}