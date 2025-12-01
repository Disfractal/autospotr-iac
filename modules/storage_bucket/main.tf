variable env {}
variable project_id {}
variable region {}

terraform {
  required_providers {
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 6.0"
      configuration_aliases = [ google-beta.default ]
    }
  }
}

# Define the Google Cloud Storage bucket
resource "google_storage_bucket" "images_bucket" {
  name                          = "${var.env}-autospotr-images"  # Replace with your desired bucket name
  location                      = var.region                               # Choose an appropriate location
  # provider                      = google-beta.default
  project                       = var.project_id                     # Replace with your Google Cloud Project ID
  # Optional: Enable uniform bucket-level access for simplified permissions
  uniform_bucket_level_access = true
}

# Link the Google Cloud Storage bucket to Firebase
resource "google_firebase_storage_bucket" "images_bucket" {
  provider    = google-beta.default
  project     = var.project_id                            # Replace with your Google Cloud Project ID
  bucket_id   = google_storage_bucket.images_bucket.name
}

# Define the Google Cloud Storage bucket
resource "google_storage_bucket" "videos_bucket" {
  name                          = "${var.env}-autospotr-videos"  # Replace with your desired bucket name
  location                      = var.region                               # Choose an appropriate location
  # provider                      = google-beta.default
  project                       = var.project_id                     # Replace with your Google Cloud Project ID
  # Optional: Enable uniform bucket-level access for simplified permissions
  uniform_bucket_level_access = true
}

# Link the Google Cloud Storage bucket to Firebase
resource "google_firebase_storage_bucket" "videos_bucket" {
  provider    = google-beta.default
  project     = var.project_id                            # Replace with your Google Cloud Project ID
  bucket_id   = google_storage_bucket.videos_bucket.name
}

output "bucket_id_video" {
    value      = google_storage_bucket.videos_bucket.name
}
