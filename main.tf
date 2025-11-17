module "project" {

  source = "./modules/project"

  apis                           = local.apis
  billing_account                = var.billing_account
  project_id                     = var.project_id
  project_name                   = var.project_name
  web_app_vms_name               = var.web_app_vms_name

  providers = {
    google-beta.default = google-beta.default
    google-beta.no_user_project_override = google-beta.no_user_project_override
  }

}

module "web_app_vms" {

  source = "./modules/web_app_vms"

  project_id                     = var.project_id
  web_app_vms_name               = var.web_app_vms_name

  providers = {
    google-beta.default = google-beta.default
  }

  # Wait for Firebase to be enabled in the Google Cloud project before creating this App.
  depends_on = [module.project.google_firebase_project]

}

