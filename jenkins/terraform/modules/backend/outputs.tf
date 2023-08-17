output "backend-ip" {
  value = google_compute_instance.backend_server.network_interface[0].access_config[0].nat_ip
}