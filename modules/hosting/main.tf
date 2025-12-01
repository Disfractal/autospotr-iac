variable bucket_vms_name_postfix {}
variable cloudbuild_connection_vms_name_postfix {}
variable cloudbuild_vms_name_postfix {}
variable env {}
variable gh_gcb_secret_name {}
variable gh_gcb_secret_version_id {}
variable gh_token {}
variable gh_uri {}
variable gh_username {}
variable gh_vms_repo {}
variable hosting_game_site_id_postfix {}
variable hosting_vms_site_id_postfix {}
variable project_id {}
variable region {}
variable web_app_vms_name {}
variable service_account_id {}

terraform {

  required_providers {
    
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }

    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 6.0"
      configuration_aliases = [ google-beta.default ]
    }

  }

}

# 3. Create a Firebase Hosting Site
resource "google_firebase_hosting_site" "game_site" {
  provider    = google-beta.default
  project     = var.project_id 
  site_id     = "${var.env}${var.hosting_game_site_id_postfix}" # Choose a unique site ID
}

# 3. Create a Firebase Hosting Site
resource "google_firebase_hosting_site" "vms_site" {
  provider    = google-beta.default
  project     = var.project_id 
  site_id     = "${var.env}${var.hosting_vms_site_id_postfix}" # Choose a unique site ID
}

# # 1. Create a Google Cloud Build v2 Connection to GitHub
# resource "google_cloudbuildv2_connection" "github_connection" {
  
#   project     = var.project_id
#   location    = var.region # Must be a specific region, not global
#   name        = "${var.env}${var.cloudbuild_connection_vms_name_postfix}"

#   github_config {

#     # Replace with your GitHub App installation ID if you are using the app integration
#     # app_installation_id = 0 

#     # Use a Personal Access Token stored in Secret Manager for simple setup
#     authorizer_credential {
#       oauth_token_secret_version = var.gh_gcb_secret_version_id
#     }

#   }

# }

# # 2. Link the specific GitHub repository to the connection
# resource "google_cloudbuildv2_repository" "github_repo" {

#   project                 = var.project_id
#   name                    = "my-terraform-ghe-repo" # A name for the repo in GCP
#   location                = var.region
#   parent_connection       = google_cloudbuildv2_connection.github_connection.name
#   remote_uri              = var.gh_uri

# }


# # 4. Create a Cloud Build trigger for GitHub
# resource "google_cloudbuild_trigger" "github_deploy_trigger" {

#   project = var.project_id
#   name    = "${var.env}${var.cloudbuild_vms_name_postfix}"
#   description = "Deploys to Firebase Hosting from GitHub"
  
#   service_account = var.service_account_id

#   github {
#     owner = var.gh_username       # Replace with your GitHub username or organization
#     name  = var.gh_vms_repo       # Replace with your GitHub repository name
#     push {
#       branch = "production" # Or your desired branch
#     }
#   }

#   # Optional: Define substitutions for use in cloudbuild.yaml
#   substitutions = {
#     _FIREBASE_PROJECT_ID = var.project_id
#     _FIREBASE_SITE_ID    = google_firebase_hosting_site.default_site.site_id
#   }

#   # Path to your Cloud Build configuration file in the repo
#   filename = "cloudbuild.yaml"

# }

# Output the Firebase Hosting site URL
output "firebase_hosting_url" {
  value = "https://${google_firebase_hosting_site.vms_site.site_id}.web.app"
}

# resource "google_storage_bucket" "default" {

#   provider                    = google-beta
#   name                        = var.env + var.bucket_vms_name_postfix
#   location                    = "US"
#   uniform_bucket_level_access = true

#   depends_on = [google_firebase_hosting_site.default]

# }

# resource "google_firebase_storage_bucket" "default" {
#   provider  = google-beta
#   project   = var.project_id
#   bucket_id = google_storage_bucket.default.name
# }

# # Creates a Firebase Web App in the new project created above.
# resource "google_firebase_web_app" "basic" {
#   provider     = google-beta.default
#   project      = var.project_id
#   display_name = var.web_app_vms_name
# }

# data "google_firebase_web_app_config" "basic" {
#   provider   = google-beta
#   project    = var.project_id
#   web_app_id = google_firebase_web_app.basic.app_id
# }

# resource "google_storage_bucket" "default" {
#     provider = google-beta
#     project  = var.project_id
#     name     = "fb-as-web-vms"
#     location = "US"
# }

# resource "google_storage_bucket_object" "default" {
#     provider = google-beta
#     bucket = google_storage_bucket.default.name
#     name = "firebase-config.json"

#     content = jsonencode({
#         appId              = google_firebase_web_app.basic.app_id
#         apiKey             = data.google_firebase_web_app_config.basic.api_key
#         authDomain         = data.google_firebase_web_app_config.basic.auth_domain
#         databaseURL        = lookup(data.google_firebase_web_app_config.basic, "database_url", "")
#         storageBucket      = lookup(data.google_firebase_web_app_config.basic, "storage_bucket", "")
#         messagingSenderId  = lookup(data.google_firebase_web_app_config.basic, "messaging_sender_id", "")
#         measurementId      = lookup(data.google_firebase_web_app_config.basic, "measurement_id", "")
#     })
# }