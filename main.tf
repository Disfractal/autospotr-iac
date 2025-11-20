module "project" {

  source = "./modules/project"

  apis                           = local.apis
  billing_account                = var.billing_account
  env                            = "dev"
  project_id                     = var.project_id
  project_name                   = var.project_name
  web_app_vms_name               = var.web_app_vms_name

  providers = {
    google-beta.default = google-beta.default
    google-beta.no_user_project_override = google-beta.no_user_project_override
  }

}

module "secret_manager" {

  source = "./modules/secret_manager"

  env                             = "dev"
  gh_gcb_secret_name              = var.gh_gcb_secret_name
  gh_token                        = var.gh_token
  project_id                      = var.project_id
  region                          = var.region

  providers = {
    google-beta.default = google-beta.default
  }

  # Wait for Firebase to be enabled in the Google Cloud project before creating this App.
  depends_on = [module.project]

}

module "service_account" {

  source = "./modules/service_account"

  env                             = "dev"
  gh_gcb_secret_name              = var.gh_gcb_secret_name 
  project_id                      = var.project_id
  secret_id                       = module.secret_manager.secret_id
  service_account_id              = var.service_account_id

  providers = {
    google-beta.default = google-beta.default
  }

  # Wait for Firebase to be enabled in the Google Cloud project before creating this App.
  depends_on = [module.secret_manager]

}

# module "hosting_vms" {

#   source = "./modules/hosting_vms"

#   bucket_vms_name_postfix                     = var.bucket_vms_name_postfix 
#   cloudbuild_connection_vms_name_postfix      = var.cloudbuild_connection_vms_name_postfix
#   cloudbuild_vms_name_postfix                 = var.cloudbuild_vms_name_postfix
#   env                                         = "dev"
#   gh_gcb_secret_version_id                    = module.secret_manager.secret_version_id
#   gh_gcb_secret_name                          = var.gh_gcb_secret_name
#   gh_token                                    = var.gh_token
#   gh_uri                                      = var.gh_uri
#   gh_username                                 = var.gh_username
#   gh_vms_repo                                 = var.gh_vms_repo
#   hosting_vms_site_id_postfix                 = var.hosting_vms_site_id_postfix
#   project_id                                  = var.project_id
#   region                                      = var.region
#   web_app_vms_name                            = var.web_app_vms_name
#   service_account_id                          = module.service_account.service_account_id

#   providers = {
#     google-beta.default = google-beta.default
#   }

#   # Wait for Firebase to be enabled in the Google Cloud project before creating this App.
#   depends_on = [module.service_account]

# }

# module "web_app_vms" {

#   source = "./modules/web_app_vms"

#   env                            = "dev"
#   project_id                     = var.project_id
#   web_app_vms_name               = var.web_app_vms_name

#   providers = {
#     google-beta.default = google-beta.default
#   }

#   # Wait for Firebase to be enabled in the Google Cloud project before creating this App.
#   depends_on = [module.service_account]

# }