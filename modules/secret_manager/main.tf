variable env {}
variable gh_gcb_secret_name {}
variable gh_token {}
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

# Create a Google Secret Manager secret
resource "google_secret_manager_secret" "github_token" {

  project                      = var.project_id
  secret_id                    = var.gh_gcb_secret_name
  labels = {
    environment = var.env
    name        = var.gh_gcb_secret_name
  }

  replication {
    # auto {} # Automatically replicate the secret across regions
    user_managed {
      replicas {
        location = var.region
      }
    }
  }

}

resource "google_secret_manager_secret_version" "github_token" {
  secret          = google_secret_manager_secret.github_token.id
  secret_data     = var.gh_token
}

# (Optional) Output the secret ID for verification
output "secret_id" {
  value = google_secret_manager_secret.github_token.secret_id
}

output "secret_version_id" {
  value = google_secret_manager_secret_version.github_token.id
}