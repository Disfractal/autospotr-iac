variable env {}
variable project_id {}
variable web_app_vms_name {}

terraform {
  required_providers {
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 6.0"
      configuration_aliases = [ google-beta.default ]
    }
  }
}

# Creates a Firebase Web App in the new project created above.
resource "google_firebase_web_app" "basic" {
  provider     = google-beta.default
  project      = var.project_id
  display_name = var.web_app_vms_name
}

data "google_firebase_web_app_config" "basic" {
  provider   = google-beta
  project    = var.project_id
  web_app_id = google_firebase_web_app.basic.app_id
}

resource "google_storage_bucket" "default" {
    provider = google-beta
    project  = var.project_id
    name     = "fb-as-web-vms"
    location = "US"
}

resource "google_storage_bucket_object" "default" {
    provider = google-beta
    bucket = google_storage_bucket.default.name
    name = "firebase-config.json"

    content = jsonencode({
        appId              = google_firebase_web_app.basic.app_id
        apiKey             = data.google_firebase_web_app_config.basic.api_key
        authDomain         = data.google_firebase_web_app_config.basic.auth_domain
        databaseURL        = lookup(data.google_firebase_web_app_config.basic, "database_url", "")
        storageBucket      = lookup(data.google_firebase_web_app_config.basic, "storage_bucket", "")
        messagingSenderId  = lookup(data.google_firebase_web_app_config.basic, "messaging_sender_id", "")
        measurementId      = lookup(data.google_firebase_web_app_config.basic, "measurement_id", "")
    })
}