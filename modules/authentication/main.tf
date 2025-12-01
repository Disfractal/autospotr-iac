variable project_id {}

# CURRENTLY NOT WORKING
# AI RECOMMENDED CODE DOESN'T EXIST IN API

terraform {

  required_providers {

    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 6.0"
      configuration_aliases = [ google-beta.default ]
    }

  }

}

resource "google_firebase_project_auth_config" "default" {

  provider = google-beta.default
  project = var.project_id

  # Enable Email/Password provider
  email_password_provider_enabled = true

  # If you need to configure other providers, you would add them here.
  # For example, for Google Sign-in:
  # google_provider_enabled = true
  # google_provider_config {
  #   client_id     = "YOUR_GOOGLE_CLIENT_ID"
  #   client_secret = "YOUR_GOOGLE_CLIENT_SECRET"
  # }

}