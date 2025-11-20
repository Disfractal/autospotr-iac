variable billing_account {}
variable bucket_vms_name_postfix {}
variable cloudbuild_connection_vms_name_postfix {}
variable cloudbuild_vms_name_postfix {}
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
variable zone {}

locals {
  apis = [
    "cloudbilling.googleapis.com",
    "cloudbuild.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "firebase.googleapis.com",
    "firebasehosting.googleapis.com",
    "secretmanager.googleapis.com",
    # Enabling the ServiceUsage API allows the new project to be quota checked from now on.
    "serviceusage.googleapis.com",
    "transcoder.googleapis.com",
  ]
}