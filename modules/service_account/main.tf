variable env {}
variable gh_gcb_secret_name {}
variable project_id {}
variable secret_id {}
variable service_account_id {}

terraform {
  required_providers {
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 6.0"
      configuration_aliases = [ google-beta.default ]
    }
  }
}

resource "google_service_account" "service_account" {
  account_id   = "${var.env}${var.service_account_id}"
  display_name = "${var.env} - Service Account for Automation"
  project      = var.project_id
}

resource "google_project_iam_member" "firebase_admin_binding" {
  
  project = var.project_id
  role    = "roles/firebase.admin"
  member  = "serviceAccount:${google_service_account.service_account.email}"

  depends_on = [
    google_service_account.service_account
  ]

}

resource "google_project_iam_member" "firebase_hosting_admin_binding" {

  project = var.project_id
  role    = "roles/firebasehosting.admin"
  member  = "serviceAccount:${google_service_account.service_account.email}"

  depends_on = [
    google_project_iam_member.firebase_admin_binding
  ]

}

resource "google_project_iam_member" "cloudbuild_builds_editor_binding" {

  project = var.project_id
  role    = "roles/cloudbuild.builds.editor"
  member  = "serviceAccount:${google_service_account.service_account.email}"

  depends_on = [
    google_project_iam_member.firebase_hosting_admin_binding
  ]

}

resource "google_secret_manager_secret_iam_member" "secret_accessor" {

  project     = var.project_id
  secret_id   = var.secret_id
  role        = "roles/secretmanager.secretAccessor"
  member      = "serviceAccount:${google_service_account.service_account.email}"

  depends_on = [
    google_project_iam_member.cloudbuild_builds_editor_binding
  ]

}

resource "google_service_account_iam_member" "token_creator" {
  service_account_id  = google_service_account.service_account.name
  role                = "roles/iam.serviceAccountTokenCreator"
  member              = "serviceAccount:${google_service_account.service_account.email}"
}


# data "google_iam_policy" "secret_accessor" {

#   binding {
#     role = "roles/secretmanager.secretAccessor"
#     members = ["serviceAccount:${google_service_account.service_account.email}"]
#   }

#   depends_on = [
#     google_secret_manager_secret_iam_member.secret_accessor
#   ]

# }

# resource "google_secret_manager_secret_iam_policy" "policy" {

#   project       = var.project_id
#   secret_id     = var.secret_id
#   policy_data   = data.google_iam_policy.secret_accessor.policy_data

#   depends_on = [
#     data.google_iam_policy.secret_accessor
#   ]

# }

output "service_account_email" {
    value      = google_service_account.service_account.email
}

output "service_account_id" {
    value      = google_service_account.service_account.id
}