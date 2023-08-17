provider "google" {
  credentials = file("credentianls.json")
  project     = var.project_id
  region      = "us-central1"
}

resource "google_storage_bucket" "website_bucket" {  
  name   = "udapeople-bucket"
  project = var.project_id
  location = "US"
  
  website {
    main_page_suffix = "index.html"
    not_found_page  = "404.html"
  }

  cors {
    origin = ["*"]
    method = ["GET", "HEAD", "PUT", "POST", "DELETE"]
    response_header = ["*"]
  }
}

resource "google_storage_bucket_iam_member" "bucket_public_read" {
  bucket = google_storage_bucket.website_bucket.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}
 
