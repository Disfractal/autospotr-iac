variable billing_account {}
variable project_id {}
variable project_name {}
variable region {}
variable web_app_vms_name {}
variable zone {}

locals {
  apis = [
    "cloudbilling.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "firebase.googleapis.com",
    # Enabling the ServiceUsage API allows the new project to be quota checked from now on.
    "serviceusage.googleapis.com",
  ]
}