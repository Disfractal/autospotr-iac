variable billing_account {}
variable bucket_vms_name_postfix {}
variable cloudbuild_connection_vms_name_postfix {}
variable cloudbuild_vms_name_postfix {}
variable firestore_name_postfix {}
variable hosting_game_site_id_postfix {}
variable hosting_vms_site_id_postfix {}
variable project_id {}
variable project_name {}
variable region {}
variable service_account_id {}
variable web_app_vms_name {}
variable gh_gcb_secret_name {}
variable gh_token {}
variable gh_uri{}
variable gh_username {}
variable gh_vms_repo {}
variable transcoder_hls_template_name {}
variable zone {}

locals {
  apis = [
    "cloudbilling.googleapis.com",
    "cloudbuild.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "eventarc.googleapis.com",
    "firebase.googleapis.com",
    "firebaseextensions.googleapis.com",
    "firebasehosting.googleapis.com",
    "firestore.googleapis.com",
    "secretmanager.googleapis.com",
    # Enabling the ServiceUsage API allows the new project to be quota checked from now on.
    "serviceusage.googleapis.com",
    "transcoder.googleapis.com",
  ]
}