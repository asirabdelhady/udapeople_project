output "website_url" {
  value = "https://${google_storage_bucket.website_bucket.name}.storage.googleapis.com"
}
