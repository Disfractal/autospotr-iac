variable apis {}
variable billing_account {}
variable project_id {}
variable project_name {}
variable web_app_vms_name {}

terraform {
  required_providers {
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 6.0"
      configuration_aliases = [ google-beta.default, google-beta.no_user_project_override ]
    }
  }
}

# Creates a new Google Cloud project.
resource "google_project" "project" {
  provider   = google-beta.no_user_project_override
  name       = var.project_name
  project_id = var.project_id

  # Required for any service that requires the Blaze pricing plan
  # (like Firebase Authentication with GCIP)
  billing_account = var.billing_account
  
  deletion_policy = "DELETE"
  
  # Required for the project to display in any list of Firebase projects.
  labels = {
    "firebase" = "enabled"
  }
}

# Enables required APIs.
resource "google_project_service" "project" {
  provider = google-beta.no_user_project_override
  project  = var.project_id
  for_each = toset(var.apis)
  service = each.key

  # Don't disable the service if the resource block is removed by accident.
  disable_on_destroy = false
}

# Enables Firebase services for the new project created above.
resource "google_firebase_project" "project" {
  provider = google-beta.default
  project  = var.project_id

  # Waits for the required APIs to be enabled.
  depends_on = [
    google_project_service.project
  ]
}
